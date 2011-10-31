class PoiCategory < ActiveRecord::Base
  default_scope :order => 'name ASC'
  has_many :pois
  belongs_to :user
end
