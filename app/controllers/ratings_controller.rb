class RatingsController < ApplicationController
  def get_rating_data
    product_id = params[:product].split('_').last.to_i
    rating = Rating.find_or_initialize_by(user_id: session[:user_id], product_id: product_id)
    rating.rating = params[:rating].to_f
    if rating.save
      render json: {avr: rating.product.avg_rating, success: true, span_id: "avg_rating_#{product_id}"}
    else
      render json: {success: false}
    end
  end
end
