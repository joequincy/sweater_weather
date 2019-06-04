class Api::V1::UsersController < Api::V1::BaseController
  def create
    begin
      user = User.create(user_params)
      render status: 201, json: UsersSerializer.new(user).to_json
    rescue
      render status: 409, json: UsersSerializer.exists
    end
  end

  private

  def user_params
    params.permit([:email, :password, :password_confirmation])
  end
end
