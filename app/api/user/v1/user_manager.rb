class User::V1::UserManager < Grape::API
  before {authenticate_request!}

  resource :get_list_user do
    desc "Read all not manager"
    get do
      if @current_user.role == "admin"
        user = User.select_user.not_manager?
        render_js user
        return
      end
      render_js nil, "bạn không có quyền", true, 500
    end
  end
end
