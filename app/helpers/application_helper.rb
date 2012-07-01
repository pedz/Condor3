module ApplicationHelper
  def add_paths
    javascript_tag do
      "$.views.helpers({
          swinfo_path: function(val) {
              return '#{swinfo_path('TARGET')}'.replace('TARGET', val);
          }
      });"
    end
  end
end
