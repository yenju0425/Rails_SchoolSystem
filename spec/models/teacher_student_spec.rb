require 'rails_helper'

RSpec.describe TeacherStudent, type: :model do
  # Test follow relationship
  it "creates a new follow relationship" do
    teacher = Teacher.create(name: "Teacher Rick")
    student = Student.create(name: "Student Rick")
    expect { TeacherStudent.create(teacher: teacher, student: student, true) }.to change { TeacherStudent.count }.by(1)
  end

  it "create a new follow relationship with a not existing teacher" do
    student = Student.create(name: "Student Rick")
    expect { TeacherStudent.create(teacher_id: 1, student: student, true) }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  it "create a new follow relationship with a not existing student" do
    teacher = Teacher.create(name: "Teacher Rick")
    expect { TeacherStudent.create(teacher: teacher, student_id: 1, true) }.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  # Test unfollow relationship
  if "deletes a follow relationship" do
    teacher = Teacher.create(name: "Teacher Rick")
    student = Student.create(name: "Student Rick")
    TeacherStudent.create(teacher: teacher, student: student)
  end

end
