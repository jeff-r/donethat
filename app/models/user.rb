class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :current_project_id, :secret_token

  has_many :projects


  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end

  def current_project
    if self.current_project_id.nil?
      nil
    else
      Project.find(self.current_project_id)
    end
  end

  def current_project= project
    self.current_project_id = project.id
  end

  def secret_token= clear_token
    if clear_token != self[:hashed_secret]
      self[:hashed_secret] = get_hashed_string(clear_token)
    end
  end

  def secret_token
    self[:hashed_secret]
  end

  def get_hashed_string str
    Digest::SHA1.hexdigest(str)
  end

  def validate_secret str
    hashed = get_hashed_string(str)
    hashed == self[:hashed_secret]
  end

end
