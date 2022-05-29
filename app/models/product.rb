class Product < ApplicationRecord
  #Validacion nivel de Aplicacion: que siempre este el valor
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
