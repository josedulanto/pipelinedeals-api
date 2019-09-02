# frozen_string_literal: true

require './lib/pd_api.rb'

class DealsService
  DEALS_PATH = 'deals.json'

  attr_accessor :page, :per_page
  attr_reader :response

  def initialize(page: nil, per_page: nil)
    @page = page
    @per_page = per_page
    @response = {}
  end

  def list_deals
    response = if ENV['ALLOW_EXTERNAL_CALLS'] || Rails.env.test?
                 conn = ::PdApi.new
                 conn.get(DEALS_PATH) do |req|
                   req.params[:per_page] = @per_page if @per_page
                   req.params[:page] = @page if @page
                 end.body
               else
                 File.read('./spec/support/deals.json')
               end

    @response = JSON.parse(response)
  end

  def chart_data
    return if @response['error']

    deals = build_deals.each do |_percent, deal|
      deal['label'] = deal.delete('name')
      deal['value'] = deal['value'].round(2)
    end

    deals.values.sort_by { |deal| deal['percent'] }
  end

  private

  def build_deals
    deals = {}

    @response['entries'].each do |entry|
      percent = entry['deal_stage']['percent']

      unless deals.key?(percent)
        entry['deal_stage'].default = 0
        deals[percent] = entry['deal_stage']
      end

      deals[percent]['value'] += entry['value'].to_f
    end

    deals
  end
end
