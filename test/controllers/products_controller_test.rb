require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest

  test "render a list of products" do
    #Cargamos la vista index
    get products_path

    assert_response :success
    #Verificamos que nos este regresando 2 items de la clase producto
    assert_select ".product", 2
  end

  test "render a detailed product page" do
    #Cargamos la vista show con el producto ps4
    get product_path(products(:ps4))

    assert_response :success
    assert_select ".title", "PS4 Fat"
    assert_select ".description", "PS4 en buen estado"
    assert_select ".price", "150"
  end

  test "render a new product form" do
    #Cargamos la vista new, osea el formulario
    get new_product_path

    #Verificamos que se cargue bien
    assert_response :success
    #Verificamos que lo que nos regresa es un formulario
    assert_select "form"
  end

  test "allow to create a new product" do
    #Creamos un nuevo producto, mandando esta peticion a products_path metodo post
    post products_path, params: {
      product: {
        title: "Nintendo 64",
        description: "Le faltan los cables",
        price: 45
      }
    }
    #Verificamos que despues de crearlo redirija a products_path osea index
    assert_redirected_to products_path
  end
end
