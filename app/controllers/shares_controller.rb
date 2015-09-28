class SharesController < ApplicationController
  def create
   if Share.where(article_id: params[:article_id], user_id: params[:user_id]).any?
    flash[:notice] = "Article already shared"
    redirect_to articles_path
   else
		@share = Share.new(user_id: params[:user_id], article_id: params[:article_id])
		@share.save
		flash[:notice] = "Article has been shared"
		redirect_to articles_path
  end
end
  def index
    @shares = Share.all
  end
  
  
  def destroy
    @share = Share.find(params[:id])
    @share.destroy
 
    redirect_to shares_path
  end
end
