class AddExamtoCollege < ActiveRecord::Migration[6.1]
  def change
    add_reference :exams, :college, index: true
  end
end
