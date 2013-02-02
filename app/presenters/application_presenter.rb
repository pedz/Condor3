# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# Class which other presenters inherit from
class ApplicationPresenter < Keynote::Presenter
  Keynote::Rumble.use_html_5_tags

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

  def home_button
    build_html do
      div.home do
        link_to(welcome_path, :class => 'home-button') do
          "Home"
        end
      end
    end
  end

  def help_button
    build_html do
      div class: 'help' do
        button class: 'help-button' do
          'Help ...'
        end
        div class: 'help-text', style: 'display: none;', title: 'Viewing a Defect' do
          help_text
        end
      end
    end
  end

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

  def icon_favicon(path, size)
    favicon_link_tag(path, rel: :icon, type: 'image/jpeg', sizes: size)
  end
end
