require 'digest'

class User < ApplicationRecord
  has_secure_password

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = Digest::SHA2.hexdigest(Time.now.to_s + email.gsub(/\W/, ''))
  end
end
