Condor3::Application.routes.draw do
  scope 'swinfos' do
    constraints(:item => /[^\/]+/) do # item can have dots in it e.g. bos.mp64 6.1.7.3
      get ':item/:sort/:page' => 'swinfos#show', :as => "swinfo_full"
      get ':item' => 'swinfos#show', :as => "swinfo_get"
      post '/' => 'swinfos#show', :as => "swinfos"
    end
  end

  scope 'which_filesets' do
    get '*path' => 'which_filesets#show', :as => 'which_filesets'
    post '/' => 'which_filesets#show', :as => 'which_filesets_post'
  end

  scope 'sha1s' do
    get ':sha1' => 'sha1s#show', :as => 'sha1s'
    post '/' => 'sha1s#show', :as => 'sha1s_post'
  end

  scope 'defects' do
    get ':defect' => 'defects#show', :as => 'defects'
    post '/' => 'defects#show', :as => 'defects_post'
  end

  scope 'changes' do
    get ':change' => 'changes#show', :as => 'changes'
    post '/' => 'changes#show', :as => 'changes_post'
  end

  scope 'file_changes' do
    get '*file' => 'file_changes#show', :as => 'file_changes'
    post '/' => 'file_changes#show', :as => 'file_changes_post'
  end

  get('src_files/:release/*path/:version' => 'src_files#show',
      :version => /[1-9][0-9]*(\.[1-9][0-9]*)+/,
      :as => 'src_files')

  get('diffs/:release/*path/:version(/:prev_version)' => 'diffs#show',
      :version => /[1-9][0-9]*(\.[1-9][0-9]*)+/,
      :prev_version => /[1-9][0-9]*(\.[1-9][0-9]*)+/,
      :as => 'diffs')

  root :to => 'welcome#index', :as => 'welcome'
end
