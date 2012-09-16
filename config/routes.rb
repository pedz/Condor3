Condor3::Application.routes.draw do
  get "which_filesets/show"

  scope 'swinfos' do
    constraints(:item => /[^\/]+/) do # item can have dots in it e.g. bos.mp64 6.1.7.3
      get ':item/:sort/:page' => 'swinfos#show', :as => "swinfo_full"
      get ':item' => 'swinfos#show', :as => "swinfo_get"
      post '/' => 'swinfos#show', :as => "swinfo_post"
    end
  end
  root :to => 'welcome#index', :as => 'welcome'
end
