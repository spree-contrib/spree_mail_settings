Spree::Core::Engine.add_routes do
  namespace :admin do
    resource :mail_method, only: [:edit, :update] do
      post :testmail, on: :collection
    end
  end
end
