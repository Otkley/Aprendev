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
    #Agregamos que el mensaje en el flash sea el correcto al crear un producto
    assert_equal flash[:notice], "Tu producto se ha creado correctamente"
  end

  test "does not allow to create a new product with empty fields" do
    #Creamos un nuevo producto, mandando esta peticion a products_path metodo post
    post products_path, params: {
      product: {
        title: "",
        description: "Le faltan los cables",
        price: 45
      }
    }
    #Verificamos que despues de crearlo redirija a products_path osea index
    assert_response :unprocessable_entity
  end

  test "render an edit product form" do
    #Cargamos la vista new, osea el formulario
    get edit_product_path(products(:ps4))

    #Verificamos que se cargue bien
    assert_response :success
    #Verificamos que lo que nos regresa es un formulario
    assert_select "form"
  end

  test "allow to update a product" do
    patch product_path(products(:ps4)), params: {
      product: {
        price: 90
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], "Tu producto se ha actualizado"
  end

  test "does not allow to update a product" do
    patch product_path(products(:ps4)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end

  test "can delete products" do
    assert_difference("Product.count", -1) do
      delete product_path(products(:ps4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], "Tu producto se ha eliminado correctamente"
  end
end
