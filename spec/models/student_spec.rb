require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:teacher) { Teacher.create(name: "Teacher Rick") }
  let(:student) { Student.create(name: "Student Rick") }

  it "creates a new student" do
    expect { student }.to change { Student.count }.by(1)
  end   

  it "soft deletes a student, updating deleted_at" do
    student.soft_delete
    expect(student.deleted_at).to be_truthy
  end

  it "soft deletes student, increasing not_active count" do
    expect { student.soft_delete }.to change { Student.not_active.count }.by(1)
  end

  it "soft deletes a student and all teachers unfollow this student" do
    teacher.follow_students([student.id])
    student.soft_delete
    expect(TeacherStudent.where(student_id: student.id).followed.count).to eq(0)
  end

  it "does not soft delete a student and all teachers still follow this student" do
    teacher.follow_students([student.id])
    expect(TeacherStudent.where(student_id: student.id).followed.count).not_to eq(0)
  end
end
