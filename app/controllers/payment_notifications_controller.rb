class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  # POST /payment_notifications
  def create
    if params[:payment_status] == "Completed" && 
        params[:secret] == PAYPAL_SECRET &&
        params[:receiver_email] == PAYPAL_EMAIL &&
        params[:mc_currency] == "GBP"
      PaymentNotification.create!(:params => params, :basket_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
      render :nothing => true
    end
  end

end
