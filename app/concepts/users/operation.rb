class User::Create < Trailblazer::Operation
  attr_accessor :user

  def process(params)
    @user = User.new(User.user_params(params))
    @user.save
  end
end

class User::Authenticate < Trailblazer::Operation
  attr_accessor :user

  def process(params)
    email, submitted_password = params[:session][:email], params[:session][:password]
    @user = User.find_by_email(email)
    return nil if @user.nil?
    return @user if @user.has_password?(submitted_password)
  end
end
