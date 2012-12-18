class ApplicationController < ActionController::Base
  # auto reload lib in development mode.
  before_filter :reload_libs if Rails.env.development?
  before_filter :authenticate

  rescue_from User::NoLDAP,        :with => :no_ldap_failure
  rescue_from User::NoUID,         :with => :no_ldap_uid
  rescue_from User::NoBootStrap,   :with => :no_boot_strap
  rescue_from User::LoginNotFound, :with => :login_not_found
  rescue_from Cmvc::CmvcError,     :with => :cmvc_error

  protect_from_forgery

  private

  # auto reload lib in development mode.
  def reload_libs
    Dir["#{Rails.root}/lib/**/*.rb"].each { |path| require_dependency path }
  end

  def user
    @user ||= User.find(:first, :conditions => { :id => session[:user_id]})
  end
  helper_method :user

  # A before_filter for the entire application.  This is a rewrite to
  # not do a db access except when the session is first created.  The
  # session has a user_name, user_id, tod when the session was created
  # and an authenticated flag.  A few sanity checks added.
  def authenticate
    authenticate_or_request_with_http_basic "Bluepages Authentication" do |user_name, password|
      return true if session_authenticated?(user_name, password)
      # Didn't like somethins so start totally clean
      reset_session
      if request.env.has_key? "REMOTE_USER"
        apache_authenticate(user_name, password)
      elsif request.headers.has_key?('HTTP_X_FORWARDED_USER')
        proxy_apache_authenticate(user_name, password)
      elsif Rails.env == "test"
        testing_authenticate(user_name, password)
      else
        ldap_authenticate(user_name, password)
      end
    end
    return false
  end

  def session_authenticated?(user_name, password)
    session[:user_name] == user_name &&
      session[:authenticated] == true &&
      !session[:user_id].blank? &&
      session[:tod] >= 1.day.ago
  end

  # This authenticates against bluepages using LDAP.
  def ldap_authenticate(user_name, password)
    logger.info("attempt to ldap authenticate: user_name #{user_name}")
    return false unless LdapUser.authenticate_from_email(user_name, password)
    return common_authenticate(user_name, password)
  end

  # Apache has already authenticated so let the user in.
  def apache_authenticate(user_name, password)
    logger.info("apache_authenticate as #{request.env["REMOTE_USER"]}")
    return false unless request.env["REMOTE_USER"] == user_name
    return common_authenticate(user_name, password)
  end

  # Apache has already authenticated but we are behind a proxy so use
  # HTTP_X_FORWARDED_USER instead
  def proxy_apache_authenticate(user_name, password)
    logger.info("proxy_apache_authenticate as #{request.env["HTTP_X_FORWARDED_USER"]}")
    return false unless request.headers["HTTP_X_FORWARDED_USER"] == user_name
    return common_authenticate(user_name, password)
  end

  # The test environment accepts any user and password (for now)
  def testing_authenticate(user_name, password)
    logger.info("testing_authenticate")
    common_authenticate(user_name, password)
    return true
  end

  # Common set up steps in the authentication process After
  # authentication succeeds, the matching user record is found.  If it
  # does not exist, it is created and initialized with the ldap_id
  # field.  The user model is stored in the session.
  def common_authenticate(user_name, password)
    logger.info("common_authenticate")
    user = User.find_by_ldap_id(user_name)
    if user.nil?
      user = User.new
      user.ldap_id = user_name
      user.save!
    end
    session[:user_name] = user_name
    session[:user_id] = user.id
    session[:authenticated] = true
    session[:tod] = Time.current
    return true
  end

  def no_ldap_failure(exception)
    @Exception = exception
    render "users/no_ldap_failure"
  end

  def no_ldap_uid(exception)
    @exception = exception
    render "users/no_ldap_uid"
  end

  def no_boot_strap(exception)
    @exception = exception
    render "users/no_boot_strap"
  end

  def login_not_found(exception)
    @exception = exception
    render "users/login_not_found"
  end

  def cmvc_error(exception)
    @exception = exception
    render "cmvcs/cmvc_error"
  end

  def create_presenter(*args)
    @presenter = present(*args)
  end

  def presenter
    @presenter
  end
  helper_method :presenter
end
