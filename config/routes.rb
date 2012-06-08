puts Condor3::Application.class
puts Condor3::Application.routes.class
Condor3::Application.routes.draw do
  match('swinfos/:item' => 'swinfos#show', :as => "swinfo", :constraints => { :item => /.*/ })
  # root :to => 'welcome#index'
end
