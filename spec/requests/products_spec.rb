require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    before do
      # algunos productos de prueba
      @product1 = Product.create(name: 'Manzana', description: 'rica manzana', price: 1.0, created_at: 2.days.ago)
      @product2 = Product.create(name: 'Pera', description: 'deliciosa Pera', price: 3.0, created_at: 1.day.ago)
      @product3 = Product.create(name: 'Zanahoria', description: 'zanahoria naranja', price: 2.0, created_at: 3.days.ago)
    end

    it "returns products matching the search query" do
      get '/products', params: { query: 'Manzana' }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json.first['name']).to eq('Manzana')
    end

    it "returns products sorted by price in ascending order" do
      get '/products', params: { sort_by: 'price', order: 'asc' }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.first['name']).to eq('Manzana')  # manzana primera
      expect(json.last['name']).to eq('Pera')  # pera ultima
    end

    it "returns paginated results" do
      get '/products', params: { page: 1, per_page: 2 }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end
  end
end
