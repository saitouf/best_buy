class Customers::SessionsController < Devise::SessionsController

  def guest_sign_in
    customer = Customer.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end