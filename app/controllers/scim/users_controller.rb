# app/controllers/scim/users_controller.rb

module Scim


  class UsersController < Scimitar::ActiveRecordBackedResourcesController
    skip_before_action :verify_authenticity_token
    skip_before_action :verify_authenticity_token

    protected

    def storage_class
      User
    end

    def storage_scope
      User.all # Or e.g. "User.where(is_deleted: false)" - whatever base scope you require
    end

  end

end

