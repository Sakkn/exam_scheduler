class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.datetime :start
      t.datetime :stop

      t.timestamps
    end
  end
end
