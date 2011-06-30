Rails.application.routes.draw do
  post :handler, :to => "sermepa_rails/handler#notify"
end
