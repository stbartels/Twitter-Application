class MicropostsController < ApplicationController
  before_filter :authenticate
  before_filter :authoerized_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted!"
    redirect_to root_path
  end
  
  private 
  
  def authoerized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user?(@micropost.user)
  end
end