# Borra todos los productos existentes para evitar duplicados
Product.delete_all

# Crea 50 productos de ejemplo
50.times do
  Product.create!(
    name: Faker::Commerce.product_name,              # Genera un nombre de producto
    description: Faker::Lorem.sentence(word_count: 10), # Genera una descripción corta
    price: Faker::Commerce.price(range: 10.0..100.0),  # Genera un precio random entre 10 y 100
    created_at: Faker::Date.between(from: 2.years.ago, to: Date.today) # Genera una fecha de creación random
  )
end

puts "Se han creado 50 productos de prueba."
