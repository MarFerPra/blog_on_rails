# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string
#  salt               :string
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  #attr_writer :encrypted_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length => {:maximum => 15, :minimum => 4}
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => { :case_sensitive => false }

                    # Aqui se genera el atributo virtual password_confirmation (true)
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..20}


# Callback -> No need, since im not using trailblazer architecture on auth.
 before_save :encrypt_password

 # True if submitted password matches user's hashed password
 def has_password?(submitted_password)
   self.encrypted_password == encrypt(submitted_password)
 end

 def self.authenticate_with_salt(id, cookie_salt)
   user = find_by_id(id)
   # Si user no es null y
   # user.salt equals la salt de la cookie -> devuelve el user else devuelve nil
   (user && user.salt == cookie_salt) ? user : nil
 end

 #TODO: make salt atrib. private eventually.

# NO trailblazable
 private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{self.password}")
  end

  def secure_hash(string)
      Digest::SHA2.hexdigest(string)
  end

  def self.user_params(params)
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
