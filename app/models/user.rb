class User < ActiveRecord::Base

  def self.scim_resource_type
    return Scimitar::Resources::User
  end

  def self.scim_attributes_map
    return {
      id:         :id,
      externalId: :scim_uid,
      userName:   :email,
      name:       {
        givenName:  :name,
        familyName: :last_name
      },
      # 'apollo-team': :team, # TODO: more to research if we need to map a custom attribute with this gem
      # emails: [
      #   {
      #     match: 'type',
      #     with:  'work',
      #     using: {
      #       value:   :work_email_address,
      #       primary: true
      #     }
      #   },
      #   {
      #     match: 'type',
      #     with:  'home',
      #     using: {
      #       value:   :home_email_address,
      #       primary: false
      #     }
      #   },
      # ],
      # phoneNumbers: [
      #   {
      #     match: 'type',
      #     with:  'work',
      #     using: {
      #       value:   :work_phone_number,
      #       primary: false
      #     }
      #   },
      # ],

      active: :active
    }
  end

  def self.scim_mutable_attributes
    return nil
  end

  def self.scim_queryable_attributes
    return {
      'userName' => {column: :email} # TODO: this should have worked with userName :  :email as symbol, but somehow breaks and needs string 'userName'
    }
  end

  # Optional but recommended.
  #
  def self.scim_timestamps_map
    {
      created:      :created_at,
      lastModified: :updated_at
    }
  end

  # If you omit any mandatory declarations, you'll get an exception raised by
  # this inclusion which tells you which method(s) need(s) to be added.
  #
  include Scimitar::Resources::Mixin
end
