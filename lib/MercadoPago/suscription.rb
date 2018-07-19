module MercadoPagoLocal
	class Suscription
		attr_reader   :mp, :amount, :customers, :id, :payment_method_id, :token
		attr_accessor :user, :plan_id, :token, :id, :payment_method_id, :amount

		def initialize ( attrs = {} )
			@id 						= attrs[:id]
		  	@user 						= attrs[:user]
		  	@plan_id 					= attrs[:plan_id]
		  	@token 						= attrs[:token]
		  	@payment_method_id			= attrs[:payment_method_id]
		  	@amount 					= attrs[:amount]
			@mp 						= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"]) #MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
		end

		def get_suscription
			@mp.get("/v1/subscriptions/#{@id}")
		end

		def self.create_plan amount, description
			mp 		= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
			body 	= Hash[
				"description" => description,
				"auto_recurring" => Hash[
		        "frequency" => 1,
		        "frequency_type" => "days",
		        "transaction_amount" => amount,
		        "currency_id" => "ARS"
		      ]
			]

			return mp.post("/v1/plans", body)
		end

		def create_suscription
			pp have_funds = MercadoPagoLocal::Card.check_card_fund(amount, token, payment_method_id, @user.email)
			if have_funds
				cards = MercadoPagoLocal::Card.save_card(@user.email, @token)
				body = Hash[
					"plan_id" 	=> @plan_id,
					"payer" 	=> Hash[
						"id"	=> @user.company.customer_id
					]
				]
				return response = mp.post("/v1/subscriptions", body)
			else
				response = {"status" => "400", "message" => "Error al procesar el pago, intente nuevamente con otra tarjeta de crédito."}
			end
		end

		def self.set_suscription_attributes response
			{
				"plan_id" 			=> response["plan_id"],
				"status" 			=> response["status"],
				"start_date" 		=> response["start_date"],
				"end_date" 			=> response["end_date"],
				"next_payment_date" => response["next_payment_date"]
			}
		end

		def cancel_suscription
			response = @mp.put("/v1/subscriptions/#{@id}", Hash["status" => "paused"])
			return Suscription.set_suscription_attributes response
		end

		def reactivate_suscription
			response = @mp.put("/v1/subscriptions/#{@id}", Hash["status" => "authorized"])
			return Suscription.set_suscription_attributes response
		end

	end
end	