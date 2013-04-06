# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Class which other presenters inherit from.
class ApplicationPresenter < Keynote::Presenter
  Keynote::Rumble.use_html_5_tags(self)

  # Returns the HTML needed for the header element of the page.
  def header_tags
    [
     icon_favicon('condor_64.jpg', '64x64'),
     icon_favicon('condor_48.jpg', '48x48'),
     icon_favicon('condor_32.jpg', '32x32'),
     icon_favicon('condor_16.jpg', '16x16'),
     favicon_link_tag,
     stylesheet_link_tag('application', media: 'all'),
     javascript_include_tag('application'),
     csrf_meta_tags
     ].join("\n").html_safe
  end

  # Creates a nice Home button used by all the pages.
  def home_button
    build_html do
      div.home do
        link_to(welcome_path, class: 'home-button') do
          "Home"
        end
      end
    end
  end

  # Creates a nice help button used by all the pages.
  def help_button
    build_html do
      div class: 'help' do
        button class: 'help-button' do
          'Help ...'
        end
        div class: 'help-text', style: 'display: none;', title: 'Help' do
          help_text
        end
      end
    end
  end

  # Returns HTML for the page's title.  Calls page_title in the
  # subclass.
  def title_heading
    build_html do
      h2.title do
        span do
          page_title
        end
      end
    end
  end

  private

  # Used by many of the subclasses to create a div containing the
  # error message they want to present.
  #
  # Added in extra processing for specific CMVC errors to give
  # directions to the user as to what to do.
  def error_block(error)
    build_html do
      div.error_block do
        if (md = /0010-183 .* FileExtract/.match(error))
          pre do
            error
          end
          p do
            text "Condor tried to fetch a copy of the file from CMVC but was"
            text "rejected.  You need to get <q>superGeneral</q> access of the".html_safe
            text "component mentioned in the above message added to your CMVC id."
          end
          p do
            text "For support personnel, the suggested process is to contact your"
            text "WW team lead and funnel the requests through them."
          end
        elsif (md = /0010-057 Login (\S+) on host (\S+).*\n.* as user (\S+)\./.match(error))
          pre do
            error
          end
          p do
            text "There are some choices of how to fix this:"
          end
          ol do
            li do
              text "Execute the command:"
              br
              text "Host -create #{md[1]}@#{md[2]} -become #{md[3]} -family aix"
              br
              text "from a host you already have CMVC access from will provide the"
              text "access Condor is needing."
            end
            li do
              text "Do these steps in a browser"
              ol do
                li do
                  text "Go to "
                  a("Reqauth4Me", href: 'http://rchasa02.rchland.ibm.com/reqauth4me')
                end
                li do
                  "Pick "
                  q "Query Logins"
                  text " on the left side."
                end
                li do
                  text "Enter your CMVC Login Id (#{md[3]}) "
                  text "and the Family (aix).  The form does a search so your serial number is not needed"
                end
                li "Once you see your login, pick it and hit \"Modify\"."
                li do
                  text "Then add "
                  q "#{md[1]}@#{md[2]}"
                  text " to the "
                  q "Hosts"
                  text " list."
                end
                li "Hit submit."
              end
            end
            li do
              text "On my Mac GUI for CMVC (which I hope is the same as the"
              text "GUI for PCs), I found the place to add a Host under the "
              q "Actions"
              text " menu, then pick "
              q "Users"
              text ", and finally"
              q "Add Hosts"
            end
          end
        else
          pre error
        end
      end
    end
  end

  # Utility method used to create an icon tag.
  def icon_favicon(path, size)
    favicon_link_tag(path, rel: :icon, type: 'image/jpeg', sizes: size)
  end
end
