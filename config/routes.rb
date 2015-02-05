# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get '/pictures', to: 'redactor_rails/pictures#index'
post '/pictures', to: 'redactor_rails/pictures#create'

post '/documents', to: 'redactor_rails/documents#create'
get '/documents', to: 'redactor_rails/documents#index'
