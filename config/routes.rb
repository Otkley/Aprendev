Rails.application.routes.draw do
  #Ruta POST, metodo create, para guardar un nuevo producto en la BD
  post "products", to: "products#create"
  #Ruta GET, metodo new, as: es el metodo helper para no poner la ruta en nuestro codigo
  get "/products/new", to: "products#new", as: :new_product
  #Ruta GET, controlador products, metodo index, vista index, products_path()
  get "/products", to: "products#index"
  #Ruta GET con id, metodo show, as: :product para product_path()
  get "/products/:id", to: "products#show", as: :product
end
