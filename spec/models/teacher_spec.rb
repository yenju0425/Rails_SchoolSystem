require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it "creates a new teacher" do
    expect { Teacher.create(name: "Teacher Rick") }.to change { Teacher.count }.by(1)
  end

  it "create a new teacher with a name" do
    teacher = Teacher.create(name: "Teacher Rick")
    expect(teacher.name).to eq("Teacher Rick")
  end
end
