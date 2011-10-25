require 'geokit'

class Poi < ActiveRecord::Base
  belongs_to :poi_category
  belongs_to :poi_set
  
  # accepts_nested_attributes_for :poi_category

  def cat
    poi_category.name if poi_category
  end
  
  def icon
    poi_category.icon if poi_category
  end
  
  def image
    
  end
  
  def url
    
  end

  def as_json(options={})
    {
      :id => id,
      :name => name,
      :description => description,
      :address => address,
      :lat => lat,
      :lng => lng,
      :cat => cat,
      :image => image,
      :url => url
    }
  end

end
