module ApplicationHelper
  def add_paths
    javascript_tag do
      "$.views.helpers({
          swinfo_path: function(val) {
              return '#{swinfo_full_path('TARGET', SwinfosController::DEFAULT_SORT_ORDER, 1)}'.replace('TARGET', val);
          }
      });".html_safe
    end
  end
end
