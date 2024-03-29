class Api::V1::Users::Ferns::StatsController < ApplicationController
  def index
    fern = Fern.find(params[:fern_id])
    options = { include: %i[interactions user],
                params: {stats: true} }
    render json: FernSerializer.new(fern, options)
  end
end