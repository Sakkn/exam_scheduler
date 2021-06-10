class College < ApplicationRecord
    has_many :users, dependent: :destroy


end
