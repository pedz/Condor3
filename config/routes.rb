Condor3::Application.routes.draw do
  constraints(:item => /[^\/]+/) do # item can have dots in it e.g. bos.mp64 6.1.7.3
    get '/swinfos/:item/:sort/:page' => 'swinfos#show', :as => "swinfo"
    match '/swinfos/:item' => redirect { |params, req|
      URI.escape("/swinfos/#{params[:item]}/#{SwinfosController::DEFAULT_SORT_ORDER}/1")
    }
  end
  
  # root :to => 'welcome#index'
end
