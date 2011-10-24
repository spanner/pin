require 'geokit'

class Poi < ActiveRecord::Base
  belongs_to :poi_category
  belongs_to :poi_set

  acts_as_mappable :auto_geocode => {:field => :address, :error_message => 'Could not geocode address'}

end
