class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.page(params[:page]).per(9)
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_groups_path, notice: 'グループを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    delete_group = Group.find(params[:id])
    if delete_group.destroy
      redirect_to admin_groups_path, notice: 'グループを削除しました。'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
