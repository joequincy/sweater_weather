class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render status: 200, json: UsersSerializer.new(user).to_json
    else
      render status: 401, json: UsersSerializer.invalid
    end
  end
end
