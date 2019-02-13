Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  

  get '/:locale' => 'welcome#index'

  # scope "/:locale" do
  #   resources :books
  # end

  scope "(:locale)", locale: /vi|en/ do
    resources :welcome
  end

  resources :books

  scope "(:locale)", locale: /vi|en|es/ do
    resources :books do
      get 'import', to: 'books#import'
    end
  end


  Rails.application.routes.draw do
    root to: "home#index"
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
