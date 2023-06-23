require 'rails_helper'

RSpec.describe "Teachers", type: :request do
  describe "POST /teachers" do
    it "creates two new teachers and logs their IDs" do
      # Prepare the teacher parameters
      teacher_params_1 = {
        teacher: {
          name: "John Doe"
        }
      }

      teacher_params_2 = {
        teacher: {
          name: "Jane Smith"
        }
      }

      # Send a POST request to create the first teacher
      post "/teachers", params: teacher_params_1

      # Expectations
      expect(response).to have_http_status(:created)
      expect(Teacher.count).to eq(1)
      expect(Teacher.last.name).to eq("John Doe")

      # Retrieve the ID of the first teacher
      teacher_id_1 = JSON.parse(response.body)['id']
      expect(teacher_id_1).to be_present

      # Send a POST request to create the second teacher
      post "/teachers", params: teacher_params_2

      # Expectations
      expect(response).to have_http_status(:created)
      expect(Teacher.count).to eq(2)
      expect(Teacher.last.name).to eq("Jane Smith")

      # Retrieve the ID of the second teacher
      teacher_id_2 = JSON.parse(response.body)['id']
      expect(teacher_id_2).to be_present

      # Log the IDs of both teachers
      puts "Teacher 1 ID: #{teacher_id_1}"
      puts "Teacher 2 ID: #{teacher_id_2}"
    end
  end
end
