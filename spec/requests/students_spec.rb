require 'rails_helper'

RSpec.describe "Students", type: :request do
  let (:student_params) do { student: { name: "John Doe" } } end # RICKASKS: Why so many curly braces?
  let (:existing_student) do 
    Student.create(name: "John Doe")
  end

  describe "POST /students" do
    it "creates a new student" do
      post "/students", params: student_params
      expect(Student.last.name).to eq("John Doe")
    end
  end

  # DELETE /students/:id
  describe "DELETE /students/:id" do
    it "deletes a existing student" do
      id = existing_student.id
      delete "/students/#{id}"
      existing_student.reload # RICKNOTE: reload is needed to update the existing_student object
      expect(existing_student.deleted_at).to be_truthy
    end

    it "deletes a non-existing student" do
      id = existing_student.id
      existing_student.destroy
      delete "/students/#{id}"
      expect(response).to have_http_status :unprocessable_entity # RICKNOTE: 422
    end
  end
end
