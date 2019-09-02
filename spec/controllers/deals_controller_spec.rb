# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  describe 'GET /deals/chart' do
    let(:labels) do
      [
        'Lost',
        'Qualified',
        'Request for Info',
        'Presentation',
        'Negotiation',
        'Won'
      ]
    end

    context 'when request is valid' do
      before do
        get :chart
      end

      it { expect(response).to have_http_status(:ok) }

      it do
        expect(JSON.parse(response.body).pluck('label')).to(
          include(*labels)
        )
      end
    end

    context 'when request is invalid' do
      before do
        allow(DealsService).to receive(:new).and_return(
          DealsService.new(per_page: 'invalid_value')
        )
        get :chart
      end

      it { expect(response).to have_http_status(:internal_server_error) }

      it do
        expect(response.body).to include({
          "status": '500',
          "error": 'Internal Server Error'
        }.to_json)
      end
    end
  end
end
