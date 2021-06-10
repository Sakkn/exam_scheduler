class AddUserToExams < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :exam, index: true
  end
end
