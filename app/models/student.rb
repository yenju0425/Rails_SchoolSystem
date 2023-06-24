class Student < ApplicationRecord
  has_many :teacher_students
  has_many :teachers, through: :teacher_students

  scope :active, -> { where(deleted_at: nil) } # RICKNOTE scope
  scope :not_active, -> { unscoped.where.not(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.now)
    TeacherStudent.where(student_id: id).update_all(followed: false)
  end
end
