# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

class ApplicationController < ActionController::Base
  # auto reload lib in development mode.
  before_filter :reload_libs if Rails.env.development?
  before_filter :authenticate
  before_filter :add_get_user_to_params

  protect_from_forgery

  private

  # auto reload lib in development mode.
  def reload_libs
    Dir["#{Rails.root}/lib/**/*.rb"].each { |path| require_dependency path }
  end

  # Add a lambda to params that returns the current user when called
  def add_get_user_to_params
    params[:get_user] = -> { user }
  end

  # Should this be merged into the lambda above?
  def user
    @user ||= User.find(:first, :conditions => { :id => session[:user_id]})
  end

  # A before_filter for the entire application.  This is a rewrite to
  # not do a db access except when the session is first created.  The
  # session has a user_name, user_id, tod when the session was created
  # and an authenticated flag.  A few sanity checks added.
  #
  # If we are not using https, we can never really be secure so the
  # sanity checks are only to make sure the application has what it
  # needs.
  def authenticate
    # if session is complete and current, then proceed
    return true if session_authenticated?

    # Didn't like something so start totally clean
    reset_session
    
    if request.env.has_key? "REMOTE_USER"
      apache_authenticate
    elsif request.headers.has_key?('HTTP_X_FORWARDED_USER')
      proxy_apache_authenticate
    else
      logger.info("attempt to authenticate with http_basic")
      authenticate_or_request_with_http_basic "Bluepages Authentication" do |user_name, password|
        # After much sole searching and net surfing, there is no way
        # to get a fast path through the authentication process
        # without introducing some test specific code into the
        # application.  Most other methods also require mocking and
        # code to set a cookie or some other piece of magic.
        #
        # I decided to just make the code obvious and not bother with
        # all the sneaky stuff.  The logic is this: In the test
        # environment, if the user is 'testuser', then the
        # authentication process is mostly bypassed; Otherwise the
        # normal process is followed.  This allows a fast path and a
        # path to fully test all the real paths and the ability to
        # pick between the two quickly and obviously.
        if Rails.env.test? && user_name == 'testuser'
          test_authenticate(user_name, password)
        else
          ldap_authenticate(user_name, password)
        end
      end
    end
  end

  def session_authenticated?
    logger.info("user_name = #{session[:user_name]}")
    logger.info("authenticated = #{session[:authenticated]}")
    logger.info("user_id = #{session[:user_id]}")
    logger.info("tod = #{session[:tod]}")
    session.has_key?(:user_name)       && !session[:user_name].blank?     &&
      session.has_key?(:authenticated) && session[:authenticated] == true &&
      session.has_key?(:user_id)       && !session[:user_id].blank?       &&
      session.has_key?(:tod)           && session[:tod] >= 1.day.ago
  end

  # This authenticates in the test environment
  def test_authenticate(user_name, password)
    logger.info("test_authenticate #{user_name}")
    return common_authenticate(user_name)
  end

  # This authenticates against bluepages using LDAP.
  def ldap_authenticate(user_name, password)
    logger.info("attempt to ldap authenticate: user_name #{user_name}")
    return false unless LdapUser.authenticate_from_email(user_name, password)
    return common_authenticate(user_name)
  end

  # Apache has already authenticated so let the user in.
  def apache_authenticate
    logger.info("apache_authenticate as #{request.env["REMOTE_USER"]}")
    return common_authenticate(request.env["REMOTE_USER"])
  end

  # Apache has already authenticated but we are behind a proxy so use
  # HTTP_X_FORWARDED_USER instead
  def proxy_apache_authenticate
    logger.info("proxy_apache_authenticate as #{request.env["HTTP_X_FORWARDED_USER"]}")
    return common_authenticate(request.env["HTTP_X_FORWARDED_USER"])
  end

  # Common set up steps in the authentication process After
  # authentication succeeds, the matching user record is found.  If it
  # does not exist, it is created and initialized with the ldap_id
  # field.  The user model is stored in the session.
  def common_authenticate(user_name)
    logger.info("common_authenticate")
    user = User.find_by_ldap_id(user_name)
    if user.nil?
      user = User.new
      user.ldap_id = user_name
      user.save!
    else
      user.touch
    end
    session[:user_name] = user_name
    session[:user_id] = user.id
    session[:authenticated] = true
    session[:tod] = Time.current
    return true
  end

  def create_presenter(*args)
    @presenter = present(*args)
  end

  def presenter
    @presenter
  end
  helper_method :presenter
end
