# app/controllers/scim/users_controller.rb

module Scim

  class UsersController < Scimitar::ResourcesController

    # SCIM clients don't use Rails CSRF tokens.
    #
    skip_before_action :verify_authenticity_token

    # If you have any filters you need to run BEFORE authentication done in
    # the superclass (typically set up in config/initializers/scimitar.rb),
    # then use "prepend_before_filter to declare these - else Scimitar's
    # own authorisation before-action filter would always run first.

    def index
      # There's a degree of heavy lifting for arbitrary storage engines.
      query = if params[:filter].present?
                attribute_map = User.new.scim_queryable_attributes() # Note use of *instance* method
                parser        = Scimitar::Lists::QueryParser.new(attribute_map)

                parser.parse(params[:filter])
                # Then use 'parser' to read e.g. #tree or #rpn and turn this into a
                # query object for your storage engine. With ActiveRecord, you could
                # just do: parser.to_activerecord_query(base_scope)
                parser.to_activerecord_query(self.storage_scope)
              else
                # Return a query object for 'all results' (e.g. User.all).
                User.all
              end
       # or User.all

      # Assuming the 'query' object above had ActiveRecord-like semantics,
      # you'd create a Scimitar::Lists::Count object with total count filled in
      # via #scim_pagination_info and obtain a page of results with something
      # like the code shown below.
      pagination_info = scim_pagination_info(query.count())
      page_of_results = query.offset(pagination_info.offset).limit(pagination_info.limit).to_a

      super(pagination_info, page_of_results) do | record |
        # Return each instance as a SCIM object, e.g. via Scimitar::Resources::Mixin#to_scim
        record.to_scim(location: url_for(action: :show, id: record.id))
      end
    end

    def show
      super do |user_id|
        user = find_user(user_id)
        # Evaluate to the record as a SCIM object, e.g. via Scimitar::Resources::Mixin#to_scim
        user.to_scim(location: url_for(action: :show, id: user_id))
      end
    end

    def create
      super do |scim_resource|
        # Create an instance based on the Scimitar::Resources::User in
        # "scim_resource" (or whatever your ::storage_class() defines via its
        # ::scim_resource_type class method).
        record = self.storage_class().new
        record.from_scim!(scim_hash: scim_resource.as_json())
        self.save!(record)
        # Evaluate to the record as a SCIM object (or do that via "self.save!")
        record.to_scim(location: url_for(action: :show, id: record.id))
      end
    end

    def replace
      super do |record_id, scim_resource|
        # Fully update an instance based on the Scimitar::Resources::User in
        # "scim_resource" (or whatever your ::storage_class() defines via its
        # ::scim_resource_type class method). For example:
        record = self.find_user(record_id)
        scim_resource.meta = nil  # this is a patch, couldn't get working without this
        record.from_scim!(scim_hash: scim_resource.as_json)
        self.save!(record)
        # Evaluate to the record as a SCIM object (or do that via "self.save!")
        record.to_scim(location: url_for(action: :show, id: record_id))
      end
    end

    def update
      super do |record_id, patch_hash|
        # Partially update an instance based on the PATCH payload *Hash* given
        # in "patch_hash" (note that unlike the "scim_resource" parameter given
        # to blocks in #create or #replace, this is *not* a high-level object).
        record = self.find_user(record_id)
        record.from_scim_patch!(patch_hash: patch_hash)
        self.save!(record)
        # Evaluate to the record as a SCIM object (or do that via "self.save!")
        record.to_scim(location: url_for(action: :show, id: record_id))
      end
    end

    def destroy
      super do |user_id|
        user = find_user(user_id)
        user.delete
      end
    end

    protected

    # The class including Scimitar::Resources::Mixin which declares mappings
    # to the entity you return in #resource_type.
    #
    def storage_class
      User
    end
    def storage_scope
      User.all # Or e.g. "User.where(is_deleted: false)" - whatever base scope you require
    end
    # Find your user. The +id+ parameter is one of YOUR identifiers, which
    # are returned in "id" fields in JSON responses via SCIM schema. If the
    # remote caller (client) doesn't want to remember your IDs and hold a
    # mapping to their IDs, then they do an index with filter on their own
    # "externalId" value and retrieve your "id" from that response.
    #
    def find_user(id)
      # Find records by your ID here.
      User.find_by(id: id)
    end

    def find_by_email(email)
      # Find records by your ID here.
      User.find_by(email: email)
    end
    # Persist 'user' - for example, if we *were* using ActiveRecord...
    #
    def save!(user)
      user.save!
    rescue ActiveRecord::RecordInvalid => exception
      raise Scimitar::ResourceInvalidError.new(record.errors.full_messages.join('; '))
    end

  end

end

