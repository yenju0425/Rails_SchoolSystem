class TeachersController < ApplicationController
  def index
    teachers = Teacher.all
    render json: teachers
  end

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.save
      render json: teacher, status: :created
    else
      render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    teacher = Teacher.find(params[:id])
    if teacher.destroy
      render json: { message: "Teacher successfully deleted." }, status: :ok
    else
      render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def follow
    # gets the teacher id from the body, and the array of student ids from the body
    teacher_id = params[:teacher_id]
    student_ids = params[:student_ids]

    student_ids.each do |student_id|
      # teacher_student = TeacherStudent.new(teacher_id: teacher_id, student_id: student_id, followed: true)
      teacher_student = TeacherStudent.find_or_initialize_by(teacher_id: teacher_id, student_id: student_id)
      teacher_student.followed = true

      if teacher_student.save
        render json: teacher_student, status: :created
      else
        render json: { errors: teacher_student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def unfollow
    # gets the teacher id from the body, and the array of student ids from the body
    teacher_id = params[:teacher_id]
    student_ids = params[:student_ids]

    student_ids.each do |student_id|
      # teacher_student = TeacherStudent.new(teacher_id: teacher_id, student_id: student_id, followed: true)
      teacher_student = TeacherStudent.find_by(teacher_id: teacher_id, student_id: student_id)
      if teacher_student.nil?
        render json: { errors: "The teacher is not following the student" }, status: :unprocessable_entity
        return
      end

      teacher_student.followed = false

      if teacher_student.save
        render json: teacher_student, status: :created
      else
        render json: { errors: teacher_student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :follow, :unfollow)
  end
end
