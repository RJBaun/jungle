class OrderMailer < ApplicationMailer

  default from: 'no-reply@jungle.com'

  def order_receipt
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Order Confirmation')
  end
end
