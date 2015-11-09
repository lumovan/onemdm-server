require 'rails_helper'

RSpec.describe HeartbeatsController, type: :controller do
  let(:heartbeat) {FactoryGirl.create(:heartbeat)}
  
  before(:each) do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(heartbeat.device.access_token)
  end
  
  describe "POST #create" do
    it "Respond with next heartbeat time" do
      post :create, format: :json
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["next_heartbeat_time"]).to 
        match(heartbeat.next_heartbeat_time) 
    end
  end


end
