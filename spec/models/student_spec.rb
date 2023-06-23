require 'rails_helper'

RSpec.describe Student, type: :model do
  it "creates a new student" do
    expect { Student.create(name: "Student Rick") }.to change { Student.count }.by(1)
  end   
  
  it "create a new student with a name" do
    student = Student.create(name: "Student Rick")
    expect(student.name).to eq("Student Rick")
  end
end
