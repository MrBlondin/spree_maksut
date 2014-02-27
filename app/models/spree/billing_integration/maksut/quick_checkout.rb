require File.dirname(__FILE__) + '/maksuturva/helper.rb'
require File.dirname(__FILE__) + '/maksuturva/notification.rb'

module Spree #:nodoc:
  module Billing
    module Integration #:nodoc:
      module Maksut #:nodoc:
        mattr_accessor :service_url
        self.service_url = 'https://www.maksuturva.fi/NewPaymentExtended.pmt'

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end


module Spree
  class BillingIntegration::Maksut::QuickCheckout < BillingIntegration
    preference :seller_id, :string, default: 'TSNRIGSB'
    preference :key_generation, :string, :default => '001'
    preference :private, :string, :default => 'P24aKmeWLkcxxY34mYQEXkDvwZn7BLHFabPctLiC'
    # preference :language, :string, :default => 'EN'
    # preference :currency, :string, :default => 'EUR'
    # preference :payment_options, :string, :default => 'ACC'

    attr_accessible :preferred_seller_id, :preferred_server, :preferred_test_mode, :preferred_key_generation, :preferred_private
    #, :preferred_language, :preferred_currency,                :preferred_payment_options 

    def provider_class
      ActiveMerchant::Billing::Maksut
    end

  end
end
