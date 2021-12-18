Rails.application.routes.draw do

  namespace 'projects', path: '/' do
    root to: 'projects#index'
    get '/projects', to: "projects#projects"
  end
end
