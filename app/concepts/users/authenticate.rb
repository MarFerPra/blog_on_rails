class User::Authenticate < Trailblazer::Operation
  attr_accessor :user

# I could probably improve this
  def process(params)
    email, submitted_password = params[:session][:email], params[:session][:password]
    @user = User.find_by_email(email)
    return nil if @user.nil?

    if !@user.has_password?(submitted_password)
      @user = nil
    end
  end
end
