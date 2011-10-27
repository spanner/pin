class PoiIcon < ActiveRecord::Base
  has_many :pois
  belongs_to :poi_category
  default_scope :order => 'name ASC'
end
