Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  # Session routes
  post "/login", to: "sessions#create"
end
