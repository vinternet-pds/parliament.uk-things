require 'rails_helper'

RSpec.describe 'contact points', type: :routing do
  describe 'ContactPointsController' do
    context 'show' do
      it 'GET contact_points#show' do
        expect(get: '/contact-points/Rbk21z4a').to route_to(
          controller:       'contact_points',
          action:           'show',
          contact_point_id: 'Rbk21z4a'
        )
      end
    end
  end
end
