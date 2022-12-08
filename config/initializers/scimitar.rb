Rails.application.config.to_prepare do
  Scimitar.engine_configuration = Scimitar::EngineConfiguration.new({
    basic_authenticator: Proc.new do |  username, password |
      puts username, password

    end
  })
end