require "jsonwebtoken"

class Base < Grape::API
  version "v1", using: :path
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  content_type :json, "application/json;charset=utf-8"
  
  helpers do
    def authenticate_request!
      token = request.headers["Authorization"].split(" ").last rescue nil
  
      error_js("plz loin", 401) unless token
  
      payload = JsonWebToken.decode token
  
      if payload.nil? || !JsonWebToken.valid_payload(payload.first)
        error_js "has error", 402
      end
  
      @current_user = User.find_by id: payload.first["user_id"]
    end

    def render_js data = nil, message = "", error = false, status = 200, opts = {}
      options = {
        status: status,
        error: error,
        message: message,
        data: data
      }
      options[:pagination] = pagination opts[:object] if opts[:object]
  
      present options, status: status
    end

    def error_js message = "", status = 200
      error!(message, status)
    end
  end

  mount Session
  mount Category::V1::CategoryController
  mount Course::V1::CourseController
  mount User::V1::UserManager
end
