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
