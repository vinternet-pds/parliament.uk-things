require 'rails_helper'

RSpec.describe Parliaments::PartiesController, vcr: true do
  describe 'GET show' do
    context '@party is nil' do
      # updated VCR cassette in order to set @party to nil
      it 'should raise ActionController::RoutingError' do
        expect{get :show, params: { parliament_id: 'fHx6P1lb', party_id: '891w1b1k' }}.to raise_error(ActionController::RoutingError)
      end
    end

    context '@party is not nil' do
      before(:each) do
        get :show, params: { parliament_id: 'fHx6P1lb', party_id: '891w1b1k' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      context '@parliament' do
        it 'assigns @parliament' do
          expect(assigns(:parliament)).to be_a(Grom::Node)
          expect(assigns(:parliament).type).to eq('https://id.parliament.uk/schema/ParliamentPeriod')
        end
      end

      context '@party' do
        it 'assigns @party' do
          expect(assigns(:party)).to be_a(Grom::Node)
          expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
        end
      end

      it 'renders the party template' do
        expect(response).to render_template('show')
      end
    end
  end

  describe '#data_check' do
    let(:data_check_methods) do
      [
        {
          route: 'show',
          parameters: { parliament_id: 'fHx6P1lb', party_id: '891w1b1k' },
          data_url: "#{ENV['PARLIAMENT_BASE_URL']}/parliament_party?parliament_id=fHx6P1lb&party_id=891w1b1k"
        }
      ]
    end

    it_behaves_like 'a data service request'
  end
end
