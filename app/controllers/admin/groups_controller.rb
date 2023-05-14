class Admin::GroupsController < ApplicationController
  
  def index
    @groups = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
    @messages = @group.messages
  end
  
  def destroy
    # group = Group.find(params[:id])
    # messages = group.messages
    # messages.destroy
    # redirect_to request.referer
  end
end
