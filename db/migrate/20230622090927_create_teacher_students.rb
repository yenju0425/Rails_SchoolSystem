class CreateTeacherStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :teacher_students do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.boolean :followed

      t.timestamps
    end
  end
end
