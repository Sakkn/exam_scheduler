class AddPhonenumberToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phoneNumber, :string
  end
end
