class UsersSerializer
  def initialize(user)
    @user = user
  end

  def to_json
    {
      api_key: user.api_key
    }
  end

  private
  attr_reader :user
end
