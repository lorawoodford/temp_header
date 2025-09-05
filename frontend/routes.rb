ArchivesSpace::Application.routes.draw do
  [AppConfig[:frontend_proxy_prefix], AppConfig[:frontend_prefix]].uniq.each do |prefix|
    scope prefix do
      # match('plugins/temp_headers' => 'temp_headers#index', :via => [:get])
      # match('plugins/temp_headers/create' => 'temp_headers#create', :via => [:post])
      # match('plugins/temp_headers/new' => 'temp_headers#new', :via => [:get])
      # match('plugins/temp_headers/show' => 'temp_headers#show', :via => [:get])
      # match('plugins/temp_headers/:id/edit' => 'temp_headers#edit', :via => [:get])
      # match('plugins/temp_headers/:id' => 'temp_headers#update', :via => [:post])
      # match('plugins/temp_headers/:id/delete' => 'temp_headers#delete', :via => [:post])
      match('plugins/temp_headers' => 'temp_headers#index', :via => [:get])
      # match('plugins/temp_headers/show' => 'temp_headers#show', :via => [:get])
      match('plugins/temp_headers/edit'   => 'temp_headers#edit',   :via => [:get])
      match('plugins/temp_headers/update' => 'temp_headers#update', :via => [:post])
    end
  end
end
