class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    unless @comment.valid?
      flash[:notice] = @comment.errors.full_messages
    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.js
    end
  end
end
 
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
    # respond_to do |format|
    #   format.html {redirect_to article_path(@article)}
    #   format.js
    # end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end