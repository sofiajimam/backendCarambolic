Rails.application.routes.draw do
  root to: redirect("/healthcheck", status: 302)
  get "/healthcheck", to: proc { [200, {}, ["success"]] }
  post "/graphql", to: "graphql#execute"
  # Session routes
  post "/login", to: "sessions#create"
end
