class ArticlesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @articles = Article.all
  end
  def saml_callback
    @articles = Article.all
    # render "articles/index"
    # print(Hash.from_xml(Base64.decode64(request.params[:SAMLResponse])))
    print(request.env['omniauth.auth'].uid) # request.env['omniauth.auth'] contains already decoded saml response
    redirect_to action: "index"
  end
  def saml_settings(tenant_settings)
    settings = OneLogin::RubySaml::Settings.new

    # You provide to IDP
    settings.assertion_consumer_service_url = "http://#{request.host_with_port}/auth/saml/#{tenant_settings[:sp_entity_id]}"
    settings.sp_entity_id                   = tenant_settings[:sp_entity_id]

    # IDP provides to you
    settings.idp_sso_target_url             = tenant_settings[:idp_sso_service_url]
    settings.idp_cert                       = tenant_settings[:idp_cert]

    settings
  end
  def sp_initiated_login
    request = OneLogin::RubySaml::Authrequest.new
    tenant_settings = SAML_SETTINGS[params[:identity_provider_id].to_sym]

    redirect_to(request.create(saml_settings tenant_settings), allow_other_host: true)
  end
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

end
