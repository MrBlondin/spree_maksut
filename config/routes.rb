Spree::Core::Engine.routes.draw do

  resources :orders do
    resource :checkout, :controller => 'checkout' do
      member do
        get :maksut_cancel
        get :maksut_return
      end
    end
  end

  match '/maksut' => 'maksut_status#update', :via => :post, :as => :maksut_status_update

end
