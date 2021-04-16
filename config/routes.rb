Rails.application.routes.draw do
  namespace :admin do
    resources :merchant
    get '', to: 'dashboard#index', as: '/'
  end

  resources :merchant do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    patch '/invoices/:invoice_id/invoice_items/:invoice_item_id', to: 'invoice_items#update'
    resources :items, only: [:index, :show]
  end
end
