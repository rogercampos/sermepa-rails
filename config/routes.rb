Rails.application.routes.draw do
  namespace :sermepa_rails do
    post :handler, :to => "sermepa_rails/handler"
  end
end
