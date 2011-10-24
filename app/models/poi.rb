require 'geokit'

class Poi < ActiveRecord::Base
  belongs_to :poi_category
  belongs_to :poi_set
end
