Rails.application.routes.draw do

    root to: 'projects#index'

    get '/projects', to: "projects#projects"

    get '/submissionCreate', to: "submissions#create"
    get '/createDownload', to: "submissions#create_download"
end
