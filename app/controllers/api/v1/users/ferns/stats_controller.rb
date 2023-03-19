class Api::V1::Users::Ferns::StatsController < ApplicationController
  def index
    fern = Fern.find(params[:fern_id])
    render json: FernSerializer.new(fern, params: { stats: true })
  end
end