class Session < Grape::API
  resource :login do
    desc "Login user"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post do
      @user = User.find_by email: params[:email]

      if @user && @user.valid_password?(params[:password])
        render_js @user.load_attribute_user, "login success"
        return
      end
      error_js "password valid false", 500
    end
  end
end
