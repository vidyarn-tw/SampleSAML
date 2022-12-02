Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
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
           :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress", # this also seems useful as it adds required name id format to sp metadata url: http://localhost:3000/auth/saml/metadata
           :attribute_service_name=>"Custom Required Attributes", # he sp metadata will add this name for requested attributes, default is "Required Attributes"
           :request_attributes=>  [ # changes sp metadata to only request the following fields.
             { :name => 'team', :name_format => 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic', :friendly_name => 'Apollo Team' },
             { :name => 'group', :name_format => 'urn:oasis:names:tc:SAML:2.0:attrname-format:basic', :friendly_name => 'Belongs to Groups' },
           ]
          # :attribute_statements=>[
          #   {:first_name => ['team']} # could not get this to work, but this can be used to map any custom attr into info hash
          # ]
            # :idp_cert_multi                     => {
           #   :signing => ["-----BEGIN CERTIFICATE-----\n...-----END CERTIFICATE-----", "-----BEGIN CERTIFICATE-----\n...-----END CERTIFICATE-----", ...],
           #   :encryption => []
           # }
  # :idp_cert_fingerprint               => "E7:91:B2:E1:...",
  #   :idp_cert_fingerprint_validator     => lambda { |fingerprint| fingerprint },
end

