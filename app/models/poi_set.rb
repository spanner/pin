class PoiSet < ActiveRecord::Base
  has_many :pois
  belongs_to :user
end
