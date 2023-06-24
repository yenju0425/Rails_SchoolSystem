require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { Teacher.create(name: "Teacher Rick") } # RICKNOTE let v.s. let!
  let(:student) { Student.create(name: "Student Rick") }
  # let!(:student) { Student.create(name: "Student Rick") } # RICKNOTE let! will create the teacher before each test

  it "creates a new teacher" do
    expect { teacher }.to change { Teacher.count }.by(1)
  end

  it "soft deletes a teacher, updating deleted_at" do
    teacher.soft_delete
    expect(teacher.deleted_at).to be_truthy
    # expect { teacher.soft_delete }.to not_eq(teacher.deleted_at)
  end

  it "soft deletes teacher, increasing not_active count" do
    expect { teacher.soft_delete }.to change { Teacher.not_active.count }.by(1)
  end

  it "soft deletes a teacher and unfollows all students" do
    teacher.follow_students([student.id])
    teacher.soft_delete
    expect(TeacherStudent.where(teacher_id: teacher.id).followed.count).to eq(0)
    # expect { teacher.soft_delete }.to change { TeacherStudent.where(followed: true).count }.by(-1)
  end

  it "does not soft delete a teacher and unfollows all students" do
    teacher.follow_students([student.id])
    expect(TeacherStudent.where(teacher_id: teacher.id).followed.count).not_to eq(0)
    # expect { teacher.soft_delete }.to change { TeacherStudent.where(followed: true).count }.by(-1)
  end
end
