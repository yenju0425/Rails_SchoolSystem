require 'rails_helper'

RSpec.describe TeacherStudent, type: :model do
  let(:teacher) { Teacher.create(name: "Teacher Rick") }
  let(:student) { Student.create(name: "Student Rick") }

  it "when a teacher follows a student" do
    expect { TeacherStudent.create(teacher: teacher, student: student, followed: true) }.to change { TeacherStudent.followed.count }.by(1)
  end

  it "when an teacher unfollows a student" do
    teacher_student = TeacherStudent.create(teacher: teacher, student: student, followed: true)
    expect { TeacherStudent.find_by(teacher: teacher, student: student).update(followed: false) }.to change { TeacherStudent.not_followed.count }.by(1)
  end

  it "when a teacher refollows a unfollowed student" do
    teacher_student = TeacherStudent.create(teacher: teacher, student: student, followed: false)
    expect { TeacherStudent.find_by(teacher: teacher, student: student).update(followed: true) }.to change { TeacherStudent.followed.count }.by(1)
  end
end
