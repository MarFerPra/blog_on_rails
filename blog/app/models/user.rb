# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

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

end
