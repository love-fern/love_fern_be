class Api::V1::FernsController < ApplicationController
  def show
    render json: FernSerializer.new(Fern.find(params[:id]))
  end
end