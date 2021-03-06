class UsersSerializer
  def initialize(user)
    @user = user
  end

  def self.exists
    {
      error: "email already exists"
    }
  end

  def self.invalid
    {
      error: "invalid email or password"
    }
  end

  def to_json
    {
      api_key: user.api_key
    }
  end

  private
  attr_reader :user
end
