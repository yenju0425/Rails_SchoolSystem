require 'rails_helper'

RSpec.describe "Teachers", type: :request do
  describe "POST /teachers" do
    it "creates a new teacher" do
      # Prepare the teacher parameters
      teacher_params = {
        teacher: {
          name: "John Doe"
        }
      }

      # Send a POST request to create a teacher
      post "/teachers", params: teacher_params

      # Expectations
      expect(response).to have_http_status(:created)
      expect(Teacher.count).to eq(1)
      expect(Teacher.last.name).to eq("John Doe")
    end
  end
end
