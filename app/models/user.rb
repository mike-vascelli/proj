class User < ActiveRecord::Base
  has_many :microposts
  validates :name, :email, presence: true, length: { maximum: 100 }
  validates :email, format: { with: /\A[\w*+\-.~&]+@[a-z\-\d]+(?:\.[a-z\-\d]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  before_save { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 },
                       format: { with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s)(?=.*\W).+/ }
end
