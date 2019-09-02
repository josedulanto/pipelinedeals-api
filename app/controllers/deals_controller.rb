# frozen_string_literal: true

class DealsController < ApplicationController
  before_action :set_deals, only: [:chart]

  def chart
    if @deals.response['error']
      render json: @deals.response, status: @deals.response['status'].to_i
    else
      render json: @deals.chart_data
    end
  end

  private

  def set_deals
    @deals = DealsService.new
    @deals.list_deals
  end
end
