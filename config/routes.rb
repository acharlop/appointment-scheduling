Rails.application.routes.draw do
  resources :appts, only: [:create, :update, :destroy, :index] #, path: "appointments"
end
