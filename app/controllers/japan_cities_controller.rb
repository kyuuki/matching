class JapanCitiesController < ApplicationController
  def index
    japan_prefecture_id = params["japan_prefecture_id"]
    @japan_cities = JapanCity.where(japan_prefecture_id: japan_prefecture_id).order(id: :desc)

    render json: @japan_cities
  end
end
