class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  def self.[](name)
    self.find_by_name(name)
  end
end