class ProductsController < ApplicationController

  def index
    products = Product.all

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      products = products.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', query, query)
    end

    if params[:sort_by].present? && params[:order].present?
      products = products.order("#{params[:sort_by]} #{params[:order]}")
    else
      products = products.order(created_at: :asc)
    end

    paginated_products = products.page(params[:page]).per(params[:per_page] || 10)

    render json: paginated_products
  end

  private

  def sort_params
    sort_by = params[:sort_by] || 'created_at'
    order = params[:order] || 'asc'
    "#{sort_by} #{order}"
  end
end
