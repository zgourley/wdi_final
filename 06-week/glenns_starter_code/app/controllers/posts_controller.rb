class PostsController < ApplicationController

  # GET /posts

  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id]) 
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      edirect_to @post, notice: 'Post was successfully updated.'      
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.' }
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
