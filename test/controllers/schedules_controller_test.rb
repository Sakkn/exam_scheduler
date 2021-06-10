require "test_helper"
require "rspec"

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should post new" do
    post schedules_new_url
    
    describe '#create' do 
      it "should not succeed with missing required fields" do
        params = { :firstName => "shane" }
  
        post "/magazine_subscriptions", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
      end

    end

    assert_response :failure
  end


  # test blue sky - exam scheduled with valid fields
  # test blue sky - exam scheduled with invalid phone (non required field)
  # test blue sky - exam scheduled with already existing exam scheduled 
  # test non blue sky - exam not scheduled outside of exam time window
  # test non blue sky - exam not scheduled missing user name
  # test non blue sky - exam not scheduled missing college id
  # test non blue sky - exam not scheduled missing exam id
  # test non blue sky - exam not scheduled invalid start date


end
