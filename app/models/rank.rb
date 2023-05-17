class Rank < ApplicationRecord
  scope :favorite_daycount, -> {order(created_at: :desc)}
  scope :favorite_weekcount, -> {order(created_at: :asc)}
  scope :favorite_monthcount, -> {order(star: :desc)}
end
