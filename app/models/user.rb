class User < ActiveRecord::Base
  has_one :parent
  belongs_to :location
  belongs_to :role


	# Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role_id, :location_id
  # attr_accessible :title, :body
  
  validates_presence_of :username, :email

  def role_symbols
    if self.role  
      # [:corporate] if self.role.role = "Corporate"
      # [:office] if self.role.role = "Office"
      # [:manager] if self.role.role = "Manager"
      # [:trainee] if self.role.role = "Trainee"
    	# [:parent] if self.role.role = "Parent"
      return ["#{self.role.role}".to_sym]      
    else
      return [:guest]
    end

     # return ["#{self.role}".to_sym]
  end

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end

  # devise create method overriden
  def create
    welcome_message
    super
  end

private

  def welcome_message
    # Devise::Mailer.welcome_message(self).deliver
    UserMailer.welcome_message(self).deliver
  end

end



