class User < ApplicationRecord
  # include ScimEngine::Schema
  def to_scim(location)
    puts"instance method", location, email
  end
end
