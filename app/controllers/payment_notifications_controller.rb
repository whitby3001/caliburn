class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  # POST /payment_notifications
  def create
    if status == "Completed" && params[:secret] == PAYPAL_CONFIG['secret'] &&
          params[:receiver_email] == PAYPAL_CONFIG['email'] &&
          params[:mc_gross] == current_basket.total_price.to_s && params[:mc_currency] == "GBP"
      PaymentNotification.create!(:params => params, :basket_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
      render :nothing => true
    end
  end

end
