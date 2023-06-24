require 'rails_helper'

RSpec.describe "Teachers", type: :request do
  let (:teacher_params) do { teacher: { name: "John Doe" } } end
  let (:existing_teacher) do
    Teacher.create(name: "John Doe")
  end

  describe "POST /teachers" do
    it "creates a new teacher" do
      post "/teachers", params: teacher_params
      expect(Teacher.last.name).to eq("John Doe")
    end
  end

  # delete /teachers/:id
  describe "DELETE /teachers/:id" do
    it "deletes a existing teacher" do
      id = existing_teacher.id
      delete "/teachers/#{id}"
      existing_teacher.reload
      expect(existing_teacher.deleted_at).to be_truthy
    end

    it "deletes a non-existing teacher" do
      id = existing_teacher.id
      existing_teacher.destroy
      delete "/teachers/#{id}"
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  # follow
  describe "POST /teachers/follow" do
    let (:student) do
      Student.create(name: "John Doe")
    end

    it "checks if a existing teacher follows existing students and successfully store the relationship" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      post "/teachers/follow", params: params
      expect(TeacherStudent.where(teacher_id: existing_teacher.id, student_id: student.id).followed.count).to eq(1)
    end

    it "checks if a existing teacher follows existing students and get a success response" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      post "/teachers/follow", params: params
      expect(response).to have_http_status :success
    end

    it "checks if a existing teacher re-follows existing non-followed students" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      TeacherStudent.create(teacher_id: existing_teacher.id, student_id: student.id, followed: false)
      post "/teachers/follow", params: params
      expect(TeacherStudent.where(teacher_id: existing_teacher.id, student_id: student.id).followed.count).to eq(1)
    end

    it "checks if a existing teacher re-follows existing already followed students" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      TeacherStudent.create(teacher_id: existing_teacher.id, student_id: student.id, followed: true)
      post "/teachers/follow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it "checks if a non-existing teacher follows existing students" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      existing_teacher.destroy
      post "/teachers/follow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it "checks if a existing teacher follows non-existing students" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      student.destroy
      post "/teachers/follow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  # unfollow
  describe "POST /teachers/unfollow" do
    let (:student) do
      Student.create(name: "John Doe")
    end

    it "checks if a existing teacher unfollows existing followed students and successfully update the relationship" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      TeacherStudent.create(teacher_id: existing_teacher.id, student_id: student.id, followed: true)
      post "/teachers/unfollow", params: params
      expect(TeacherStudent.where(teacher_id: existing_teacher.id, student_id: student.id).not_followed.count).to eq(1)
    end

    it "checks if a existing teacher unfollows existing unfollowed students and return error" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      TeacherStudent.create(teacher_id: existing_teacher.id, student_id: student.id, followed: false)
      post "/teachers/unfollow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it "checks if a existing teacher unfollows existing never followed students and return error" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      post "/teachers/unfollow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it "checks if a non-existing teacher follows existing students" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      existing_teacher.destroy
      post "/teachers/unfollow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it "checks if a existing teacher follows non-existing students" do
      params = {
        teacher_id: existing_teacher.id,
        student_ids: [student.id]
      }

      student.destroy
      post "/teachers/unfollow", params: params
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
