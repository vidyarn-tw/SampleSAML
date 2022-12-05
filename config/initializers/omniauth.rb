

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth::MultiProvider.register(self,
                                   provider_name: :saml,
                                   identity_provider_id_regex: /\w+/,
                                   path_prefix: '/auth/saml',
                                   callback_suffix: 'callback',
                                   # Specify any additional provider specific options
                                   name_identifier_format: 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
                                   issuer: 'apollo.io',
                                   allowed_clock_drift: 5.seconds) do |identity_provider_id, rack_env|
    # identity_provider = SAML::IdentityProvider.find(identity_provider_id)

    # rack_env['apollo.saml_identity_provider'] = identity_provider
    # identity_provider.options
    map_of_opts = {
      :exk7e2ybcuv3mjudc5d7 => {
        # :provider=> :saml,
        # :assertion_consumer_service_url     => "consumer_service_url",
        :sp_entity_id                       => "exk7e2ybcuv3mJUdc5d7",
        :idp_sso_service_url                => "https://dev-27371526.okta.com/app/dev-27371526_samplesamlapp_1/exk7e2ybcuv3mJUdc5d7/sso/saml",
        # :idp_sso_service_url_runtime_params => {:original_request_param => :mapped_idp_param},
        :idp_cert                           => "-----BEGIN CERTIFICATE-----
MIIDqDCCApCgAwIBAgIGAYStGtr3MA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG
A1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU
MBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0yNzM3MTUyNjEcMBoGCSqGSIb3DQEJ
ARYNaW5mb0Bva3RhLmNvbTAeFw0yMjExMjUwNDQ0MjlaFw0zMjExMjUwNDQ1MjlaMIGUMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG
A1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0yNzM3MTUyNjEc
MBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALeR+tR6vxYAqYWt7r0vafrqbPbJjTgLKZcZl7V0JNUHZzoQNCazWnOxwMx7aEIJHe0IpVmJ
UAhCeE3rldjfpR7Qou3qdzFTzF+SjqDjsACf/WlLNX9SBbMpqr5ASFoOl/69VQNtwn7YAKcq15Jc
biU961jhFsV6PiBkJb2lffjlwTFJHkUXKioZNDcv0eCxcRKgYBHGfqi8nTHAK29vd5zCQm2T/umT
mC0XDcHLRdUc5syKF4h3f2IbZXK1rvfGwiLxWnz2KiyK3PkrMV4rh9edOOuHpvl9CBud5hY2TH9s
XXpwPNrtRgu+Ty5OVlUYoFQp4sZAKZY0wtecZk+aFH8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA
fowFCiec5kihxvYV+I8lS5OaEFjohGC4rKizREDIR0VjXe9DyrtOJXMjBwduOk1VyukjWOmCQKI1
U6KWyKIVtcsUuw49ocw6FfMsJ9Gu/2Ts6KF2nuWkZRFRRInbb0KbWSN19Zuf02Ar7iJEGtok2jGZ
T+EJQ4wC3rONwPaJdKpATmy3zogojOfMOnb/kQb7Z59CKv7Zj9KD1xAvNLZG7mh0+e/JfkkzIFMX
36QMrhUVluva2CsrKrgHTyoNiENK/3e9w6nrzYTZaGd+VNsf5H6hNBnz+Va3EZof31RGIk7o2WPy
S+/5+/c5AyVLmgHmkKXpnOA2wH9OeJLyXq5+5w==
-----END CERTIFICATE-----",
        # :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress", # this also seems useful as it adds required name id format to sp metadata url: http://localhost:3000/auth/saml/metadata
        :attribute_service_name=>"Custom Required Attributes", # he sp metadata will add this name for requested attributes, default is "Required Attributes"
        :request_attributes=>  [ # changes sp metadata to only request the following fields.
          { :name => 'team', :name_format => 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic', :friendly_name => 'Apollo Team' },
          { :name => 'group', :name_format => 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic', :friendly_name => 'Belongs to Groups' },
        ]
      },
      :exk7ds6bfkplszknm5d7 => {
                  # :provider=> :saml,
                   # :assertion_consumer_service_url     => "consumer_service_url",
                   :sp_entity_id                       => "exk7ds6bfkPLszKNm5d7",
                   :idp_sso_service_url                => "https://dev-28219840.okta.com/app/dev-28219840_mysamldummyapp_1/exk7ds6bfkPLszKNm5d7/sso/saml",
                   # :idp_sso_service_url_runtime_params => {:original_request_param => :mapped_idp_param},
                   :idp_cert                           => "-----BEGIN CERTIFICATE-----
        MIIDqDCCApCgAwIBAgIGAYSpBdDmMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG
        A1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU
        MBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0yODIxOTg0MDEcMBoGCSqGSIb3DQEJ
        ARYNaW5mb0Bva3RhLmNvbTAeFw0yMjExMjQwOTQzMDFaFw0zMjExMjQwOTQ0MDFaMIGUMQswCQYD
        VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG
        A1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0yODIxOTg0MDEc
        MBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
        ggEBAMKqcieT6krfpgf/Ry6tQDoftgUXM1sqcaQ6x0GOgO61+kk2bdloqeiicGt7uoQO8KGK7snN
        tEJNCn7vkAD6E627Yhr/PndbCF3663ZItVgvPvnzTE4BRa1y+h8JSOt24Ac1TdATgxT6JnmMcgbQ
        955e/2iVG7IWyoBZLgw3p1vuQyqMxLHnotGaBEiXARgexo+G2q69JEYvXBVT0SWnP5XK5eh7QVQG
        jeMiJ9AS9PpF18WnWGxTaMLPPXs9a1/IBcFrVu+A31wW9KkO3RirUwS7iBnpudhF/JMWpR9C8jBU
        0z+0/BH+chlsxHSy5c8GC9U47/32GkKQgjv1fyu27IMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA
        VasffvFyrytv1XSxvwBhOX/b5r0SB1kfbSfEfDfs3k0/hzPLL6hWFLXbKhog1bwKhq+PIbpjdYAz
        72uKVxcrNmzxyKfegWYJ6PjM0rHbWrrZs3vuuxSYMD0ec8E2mwxJE0iurvXOwJXNLA8bK/Gwz0BO
        Xyena19I62A3ES75AzqLltUIjkiCyEJGhjqlK/BycMxcV4q+OGSmHTa/IvKLq4Fgal05Lw8BtOeN
        g3I8hlhHtG5O3nsiQtN3AcVPMuEnTNaunmsBqTW4KMFxhlQRY7j8HcaHGjHOVjejAoBeXeYBfIDa
        b18uR5DiEuNoJMq1ksFwMsjg71slFSEJ8Pkw4Q==
        -----END CERTIFICATE-----",
                   # :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress", # this also seems useful as it adds required name id format to sp metadata url: http://localhost:3000/auth/saml/metadata
                   :attribute_service_name=>"Custom Required Attributes", # he sp metadata will add this name for requested attributes, default is "Required Attributes"
                   :request_attributes=>  [ # changes sp metadata to only request the following fields.
                     { :name => 'team', :name_format => 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic', :friendly_name => 'Apollo Team' },
                     { :name => 'group', :name_format => 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic', :friendly_name => 'Belongs to Groups' },
                   ]
        }
    }
    map_of_opts[identity_provider_id.to_sym]
  end
end

# monkey patch to support metadata paths - hacked version of:
#    https://github.com/salsify/omniauth-multi-provider/issues/4#issuecomment-366452170
#
# This patches omn-auth-saml to ensure setup_phase is called at the beginning of other_phase
# (which is consistent with how it handles request_phase and callback_phase).
module OmniAuthSamlOtherPhaseSetupPatch
  def on_auth_path?
    # Override this to ensure initialization happens properly in OmniAuth::Strategies::SAML for "other"
    # requests
    current_path.start_with?(options.path_prefix)
  end

  def on_other_path?
    # Override this to ensure initialization happens properly in OmniAuth::Strategies::SAML for "other"
    # requests
    current_path.match(%r{/(?:metadata|spslo|slo)\z})
  end

  def other_phase
    # Override the other_phase method to call setup_phase before checking to see if the request
    # is on an "other" request path. This ensures omniauth-multi-provider has setup the path
    # prefix properly for the given identity provider. By default omniauth won't call setup_phase until
    # after checking the path.
    @callback_path = nil
    setup_phase if on_auth_path? && on_other_path?
    super
  end

  def setup_phase
    # Make sure we only perform setup once since this method will be called twice during the other phase
    unless @setup  # TODO: always false due to the calling class being created anew each time?
      super
      @setup = true
    end
  end
end

OmniAuth::Strategies::SAML.prepend(OmniAuthSamlOtherPhaseSetupPatch)