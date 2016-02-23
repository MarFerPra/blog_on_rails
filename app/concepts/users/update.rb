class User::Update < Trailblazer::Operation
  attr_accessor :user
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  contract do
    property  :name, validates: { presence: true,
                     length: {maximum: 15, minimum: 4}}

    property  :email, validates: { presence: true,
                      format: {with: email_regex} }
# :uniqueness => { :case_sensitive => false }
# Uniqueness must be checked in database level
# Can't check it here if Create class does not inherit from ActiveRecord(::Base)

    property :password, validates: { presence: true,
                         #confirmation: true,
                         length: {within: 6..20} }
  end

  def process(params)
    @user = User.find(params[:id])
    checked_params = User.user_params(params)
    validate(checked_params, @user) do |f|
    @user.update(checked_params)
    end
  end
end
