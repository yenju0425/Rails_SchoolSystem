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
    # check student
    student = Student.find_by(id: params[:id], deleted_at: nil)
    unless student
      render json: { errors: "Student not found" }, status: :unprocessable_entity
      return
    end

    if student.soft_delete # RICKNOTE soft_delete
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
