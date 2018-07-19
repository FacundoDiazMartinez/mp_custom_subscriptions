module MercadoPagoLocal
	class Card
		attr_reader   :customer_email, :customer
		attr_accessor :card_id, :company_id, :mp, :customer_email

		def initialize(attrs = {})
			 @card_id 			= attrs[:card_id]
			 @customer_email 	= attrs[:customer_email]
			 @company			= Company.find(attrs[:company_id])
			 @mp 				= MercadoPago.new(@company.mp_access_token)
		end

		def self.get_cards email
			mp 			= MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			customer_id = MercadoPagoLocal::Customer.get_customer_id(email)
			mp.get("/v1/customers/#{customer_id}/cards")
		end

		def self.have_cards? email
			cards = get_cards(email)
			if cards["status"] == "200"
				if cards["response"].empty?
					return false
				else
					return true
				end
			else
				return false
			end
		end

		def self.save_card email, token
			mp 			= MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			customer_id = MercadoPagoLocal::Customer.get_customer_id(email)
			mp.post("/v1/customers/#{customer_id}/cards", Hash["token" => token])
		end

		def self.check_card_fund amount, token, payment_method_id, email
			pp response = MercadoPagoLocal::Payment.new(
				amount: amount,
				token: token,
				description: "Checkeo de fondos disponibles",
				installments: 1,
				payment_method_id: payment_method_id,
				payer: Hash["email" => email],
				capture: false
			).send_payment

			if response["status"] == "201"
				if response["response"]["status"] == "authorized" && response["response"]["status_detail"] == "pending_capture"
					realese_captured_funds(response["response"]["id"])
					return true
				else
					return false
				end
			else
				return false
			end
		end

		def self.realese_captured_funds id
			mp 		= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
			paymentData = Hash[
				"status" => "cancelled"
			]

			payment = mp.put("/v1/payments/#{id}", paymentData);
		end
	end
end