# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DealsService do
  let(:deals_service) { described_class.new }

  context 'when PipelineDeals API request is valid' do
    context 'with #list_deals' do
      it 'returns a list of deals' do
        expect(deals_service.list_deals).to include(
          JSON.parse(File.read('./spec/support/deals.json'))
        )
      end
    end

    context 'with #chart_data' do
      it 'returns a list with the total deal value by stage and ordered ' \
        'by deal stage percent' do
        deals_service.list_deals
        expect(deals_service.chart_data).to eq(
          JSON.parse(File.read('./spec/support/chart_data.json'))
        )
      end
    end
  end

  context 'when PipelineDeals API request is not valid' do
    before do
      allow(described_class).to receive(:new).and_return(
        described_class.new(per_page: 'invalid_value')
      )
    end

    context 'with #list_deals' do
      it do
        expect(deals_service.list_deals).to eq(
          'error' => 'Internal Server Error',
          'status' => '500'
        )
      end
    end

    context 'with #chart_data' do
      it do
        deals_service.list_deals
        expect(deals_service.chart_data).to be_nil
      end
    end
  end
end
