class ApplicationPresenter < Keynote::Presenter
  def header_tags
    out =  icon_favicon('condor_64.jpg', '64x64')
    out << icon_favicon('condor_48.jpg', '48x48')
    out << icon_favicon('condor_32.jpg', '32x32')
    out << icon_favicon('condor_16.jpg', '16x16')
    out << favicon_link_tag
    out << stylesheet_link_tag('application', media: 'all')
    out << javascript_include_tag('application')
    out << csrf_meta_tags
    out.html_safe
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
