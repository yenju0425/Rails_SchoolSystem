class TeacherStudent < ApplicationRecord
  belongs_to :teacher
  belongs_to :student

  scope :followed, -> { where(followed: true) } # RICKNOTE scope
  scope :not_followed, -> { where(followed: false) }
end
