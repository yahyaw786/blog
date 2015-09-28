class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable	
  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.confirmed_at = Time.now
    end
  end       
  def self.connect_to_linkedin(auth, signed_in_resource=nil) 
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    if user
      return user 
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user 
        return registered_user 
      else 
        user = User.create(provider:auth.provider, uid:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20])
        user.confirmed_at = Time.now
      end 
    end 
  end

end
