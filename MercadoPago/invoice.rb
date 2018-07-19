module MercadoPagoLocal
	class Invoice
		attr_accessor :card_id, :company_id, :mp, :customer_email

		def self.get_invoice id
			mp 		= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
			mp_inv 	= mp.get("/v1/invoices/#{id}")["response"]
		end

		def self.set_invoice_attributes response
			{						
				"invoice_id" 		=> response["id"],
				"plan_id" 			=> response["plan_id"],
				"suscription_id" 	=> response["subscription_id"],
				"status" 			=> response["status"],
				"debit_date" 		=> response["debit_date"].to_datetime
			}
		end
	end
end