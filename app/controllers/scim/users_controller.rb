# app/controllers/scim/users_controller.rb

module Scim

  # ScimEngine::ResourcesController uses a template method so that the
  # subclasses can provide the fillers with minimal effort solely focused on
  # application code leaving the SCIM protocol and schema specific code within the
  # engine.

  class UsersController < ScimEngine::ResourcesController
    skip_before_action :verify_authenticity_token

    def index
        users = User.all
        users[0].to_scim(location: url_for(action: :index))
    end
    def show
      super do |user_id|
        user = find_user(user_id)
        user.to_scim(location: url_for(action: :show, id: user_id))
      end
    end

    def create
      super(resource_type, &method(:save))
    end

    def update
      super(resource_type, &method(:save))
    end

    def destroy
      super do |user_id|
        user = find_user(user_id)
        user.delete
      end
    end


    protected

    def save(scim_user, is_create: false)
      #convert the ScimEngine::Resources::User to your application object
      #and save
    rescue ActiveRecord::RecordInvalid => exception
      # Map the internal errors to a ScimEngine error
      raise ScimEngine::ResourceInvalidError.new('record invalid custom error')
    end

    # tell the base controller which resource you're handling
    def resource_type
      ScimEngine::Resources::User
    end

    def find_user(user_id)
      # find your user
      User.first
    end

  end
end
