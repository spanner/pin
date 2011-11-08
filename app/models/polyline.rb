class Polyline < ActiveRecord::Base
  has_many :line_points
  has_many :pois, :through => :line_points
  belongs_to :user
end
