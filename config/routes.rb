Condor3::Application.routes.draw do
  constraints(:item => /[^\/]+/) do # item can have dots in it e.g. bos.mp64 6.1.7.3
    get '/swinfos/:item/:sort/:page' => 'swinfos#show', :as => "swinfo"
    if Rails.application.config.relative_url_root
      tmp = "#{Rails.application.config.relative_url_root}/swinfos"
    else
      tmp = "/swinfos"
    end
    match '/swinfos/:item' => redirect { |params, req|
        URI.escape("#{tmp}/#{params[:item]}/#{SwinfosController::DEFAULT_SORT_ORDER}/1")
    }
  end
  
  # root :to => 'welcome#index'
end
