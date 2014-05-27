Pitagoras::Application.routes.draw do
  
  resources :logins, only: [:new, :create, :logout]
  resources :profesors, only: [:new, :create]
  resources :estudiantes, only: [:new, :create]

resources :logins do               
 collection do         
  get :logout           
 end        
end

resources :estudiantes do               
 collection do    
   post :verNotas     
   post :suscribirse          
 end        
end 

resources :profesors do               
 collection do    
   post :leer_notas             
 end        
end 
  root to: 'logins#new'

  get "/pages/*id", to: 'pages#show'

end
