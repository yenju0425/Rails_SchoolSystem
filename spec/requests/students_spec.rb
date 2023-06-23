require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "POST /students" do
    it "creates a new student" do
      # Prepare the student parameters
      student_params = {
        student: {
          name: "John Doe"
        }
      }

      # Send a POST request to create a student
      post "/students", params: student_params

      # Expectations
      expect(response).to have_http_status(:created)
      expect(Student.count).to eq(1)
      expect(Student.last.name).to eq("John Doe")
    end
  end
end
