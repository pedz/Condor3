class SwinfoPresenter < ApplicationPresenter
  presents :swinfo

  def page_title
    "swinfo for #{@item}"
  end

  def help_text
    build_html do
      p do
        "Lots of help needed here"
      end
    end
  end

  def header_tags
    out = super
    out << javascript_tag do
      "$.views.helpers({
          swinfo_path: function(val) {
              return '#{swinfo_full_path('TARGET', SwinfosController::DEFAULT_SORT_ORDER, 1)}'.replace('TARGET', val);
          }
      });".html_safe
    end
  end
end
