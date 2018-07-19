module MercadoPagoLocal
	require 'mercadopago.rb'
	class NullOrInvalidAttribute < StandardError; end

	autoload :User, "MercadoPago/user"
	autoload :Payment, "MercadoPago/payment"
	autoload :WebHook, "MercadoPago/webhook"
	autoload :ResponseHandler, "MercadoPago/response_handler"
	autoload :Card, "MercadoPago/card"
	autoload :Customer, "MercadoPago/customer"
	autoload :Preapproval, "MercadoPago/preapproval"
	autoload :Suscription, "MercadoPago/suscription"
	autoload :Invoice, "MercadoPago/invoice"

	class << self
        mattr_accessor :business_name, :mail_from
    end

    def self.setup(&block)
        yield self
    end
	
end