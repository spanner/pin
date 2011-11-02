class User < ActiveRecord::Base
  has_many :pois
  has_many :poi_categories
  has_many :poi_icons
  has_many :poi_sets
  has_and_belongs_to_many :roles

  # Include default devise modules. Others available are:
  # :validatable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable, 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_facebook_uid(data["id"])
      user
    end
  end
  
  def role?(role)
    !!self.roles.find_by_name(role)
  end
  
  def admin?
    role?('admin')
  end

  def registered?
    role?('registered')
  end

  def guest?
    new_record? || roles.empty?
  end

  # Guest accounts are set up without any real content
  # and exist only to hold things together until a user registers or logs in.
  #
  def email_changed?
    !guest? && !!email_change
  end
  
protected
  
end
