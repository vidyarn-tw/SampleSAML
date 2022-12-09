
Scimitar.engine_configuration = Scimitar::EngineConfiguration.new({
  basic_authenticator: Proc.new do |  username, password |
    username == 'naeemshaikh27@gmail.com' && password == 'Admin1234'
  end
})
