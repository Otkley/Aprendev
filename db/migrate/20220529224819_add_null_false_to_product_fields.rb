class AddNullFalseToProductFields < ActiveRecord::Migration[7.0]
  def change
    #Validacion nivel Base de Datos para que los valores no esten vacios
    change_column_null :products, :title, false
    change_column_null :products, :description, false
    change_column_null :products, :price, false
  end
end
