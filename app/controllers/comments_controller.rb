class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.commenter = current_user.username
    if @comment.content.length >= 1
      @comment.save!
      redirect_to article_path(@article)
    else
      flash[:alert] = "You forget to write your comment!"
      redirect_to article_path(@article)
    end
  end

  def destroy
    if current_user.email == "atom-1121@mail.ru"
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
    end
  end

  private
  def comment_params
    :user_id=>current_user_id
    params.require(:comment).permit(:commenter, :content, :user_id)
  end
end