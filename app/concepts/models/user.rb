require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password
  #attr_writer :encrypted_password

# Callback -> No need, since im not using trailblazer architecture on auth.
 before_save :encrypt_password

 def canEdit?(param)
   if param.is_a? User
     return true if(self.email == param.email || self.isAdmin? )
   elsif param.is_a? Article
     return true if(param.author == self.name || self.isAdmin? )
   elsif param.is_a? Comment
     return true if(param.commenter == self.name || self.isAdmin? )
   end
 end

 # Should change this - eventually.
 def isAdmin?
   return true if (self.name == "admin" && self.email == "admin@admin.xyz")
 end

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

# Untrailblazable
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
    params.require(:user).permit(:name, :email, :password)
  end

end
