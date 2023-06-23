class StudentsController < ApplicationController
  def index
    students = Student.all
    render json: students
  end

  def create
    student = Student.new(student_params)
    if student.save
      render json: student, status: :created
    else
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    student = Student.find(params[:id])
    if student.destroy
      render json: { message: "Student successfully deleted." }, status: :ok
    else
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def student_params
    params.require(:student).permit(:name)
  end
end
