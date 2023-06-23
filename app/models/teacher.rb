class Teacher < ApplicationRecord
  has_many :teacher_students
  has_many :students, through: :teacher_students

  def follow_students(student_ids)
    # check students
    valid_student_ids = Student.where(id: student_ids).pluck(:id)
    invalid_student_ids = student_ids - valid_student_ids
    
    follow_failed_ids = []
    valid_student_ids.each do |student_id|
      student = Student.find(student_id)
      teacher_student = TeacherStudent.find_or_initialize_by(teacher_id: id, student_id: student_id)
      if teacher_student.followed
        follow_failed_ids << student_id # Cannot follow a student that is already followed
        next
      end

      teacher_student.followed = true
      unless teacher_student.save # RICKNOTE save v.s. save!
        follow_failed_ids << student_id
      end
    end

    unless invalid_student_ids.empty?
      raise ActiveRecord::InvalidForeignKey.new("One or more students not found #{invalid_student_ids}")
    end

    follow_failed_ids # return failed ids
  end

  def unfollow_students(student_ids)
    # check students
    valid_student_ids = Student.where(id: student_ids).pluck(:id)
    invalid_student_ids = student_ids - valid_student_ids

    unfollow_failed_ids = []
    valid_student_ids.each do |student_id|
      student = Student.find(student_id)
      teacher_student = TeacherStudent.find_by(teacher_id: id, student_id: student_id)
      if teacher_student
        unless teacher_student.followed
          unfollow_failed_ids << student_id
        end

        teacher_student.followed = false
        unless teacher_student.save # RICKNOTE save v.s. save!
          unfollow_failed_ids << student_id
        end
      else
        unfollow_failed_ids << student_id # Cannot unfollow a student that is not followed
      end

      unless invalid_student_ids.empty?
        raise ActiveRecord::InvalidForeignKey.new("One or more students not found #{invalid_student_ids}")
      end
    end

    unless invalid_student_ids.empty?
      raise ActiveRecord::InvalidForeignKey.new("One or more students not found #{invalid_student_ids}")
    end

    unfollow_failed_ids # return failed ids
  end
end
