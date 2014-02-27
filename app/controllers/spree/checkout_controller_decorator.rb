require 'net/http'
require 'uri'
  
module Spree
  CheckoutController.class_eval do
    before_filter :confirm_maksut, :only => [:update]

    def maksut_return
      payment_method = PaymentMethod.find(params[:payment_method_id])
      payment = @order.payments.create(:amount => @order.total,
                                       :payment_method_id => params[:payment_method_id])

      payment.started_processing!

      # record_log payment, ppx_auth_response
      payment.complete!

      @order.update_attributes({:state => "complete", :completed_at => Time.now}, :without_protection => true)

        # Unset the order id as it's completed.
      session[:order_id] = nil

      @order.finalize!
      flash[:commerce_tracking] = "true"

      flash.notice = t(:order_processed_successfully)
      redirect_to completion_route
    end

    def maksut_cancel
      flash[:error] = t(:payment_has_been_cancelled)
      redirect_to edit_order_path(@order)
    end

    private

    def confirm_maksut
      return unless (params[:state] == "payment") && params[:order][:payments_attributes]

      payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
      if payment_method.kind_of?(BillingIntegration::Maksut::QuickCheckout)
        #TODO confirming payment method
        # redirect_to edit_order_checkout_url(@order, :state => 'confirm'), notice: t(:complete_maksut_checkout)

        uri = URI.parse('http://test1.maksuturva.fi/NewPaymentExtended.pmt')
        #http=Net::HTTP.new(uri.host, uri.port)
        #http.use_ssl = true

        #request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
        #request.body = params.to_json

        #response = http.request(request)
        response= Net::HTTP.post_form(URI.parse('http://test1.maksuturva.fi/NewPaymentExtended.pmt'), params)
        #redirect_to uri.to_s, params
        service_url='http://test1.maksuturva.fi/NewPaymentExtended.pmt'
      end
    end
  end
end
