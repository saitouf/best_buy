class Public::GroupsController < ApplicationController
  # before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  # before_action :set_group, only: [:edit, :update]

  def index
    @groups = Group.page(params[:page]).per(9)
    @group_joining = GroupUser.where(customer_id: current_customer.id)
    @groups_none = "グループに参加していません。"
  end

  def new
    @group = Group.new
    @group.customers << current_customer
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_customer.id
    if @group.save
      redirect_to groups_url, notice: 'グループを作成しました。'
    else
      render :new
    end
  end

  def show
    # @messages = Message.all
    @group = Group.find(params[:id])
    @messages = @group.messages
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: 'グループを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    delete_group = Group.find(params[:id])
    if delete_group.destroy
      redirect_to groups_path, notice: 'グループを削除しました。'
    end
  end
  
  def search
    @groups = Group.search(params[:group_keyword]).page(params[:page]).per(10)
    @group_keyword = params[:group_keyword]
    render "index"
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
  
  # def ensure_correct_customer
  #   @group = Group.find(params[:id])
  #   unless @group.customer == current_customer
  #   redirect_to post_items_path
  #   end
  # end

  # def set_group
  #   @group = Group.find(params[:id])
  # end
end
