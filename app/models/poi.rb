require 'geokit'

class Poi < ActiveRecord::Base
  belongs_to :poi_category
  belongs_to :poi_set

  def as_json(options={})
    basis = {
      :id => id,
      :name => name,
      :description => description,
      :address => address,
      :lat => lat,
      :lng => lng,
    }
    basis[:cat] = poi_category.name if poi_category
    basis 
  end

end
