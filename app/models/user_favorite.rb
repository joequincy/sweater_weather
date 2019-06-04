class UserFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :favorite, class_name: :Location
end
