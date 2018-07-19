module MercadoPagoLocal
	class Payment
		attr_reader   :mp, :company, :transaction_amount, :application_fee, :capture
		attr_accessor :amount,:token, :description, :payer, :document, :transaction_type, :installments, :payment_method_id, :issuer_id, :company,
					  :mercadopagotransaction, :mp_transactions_id, :capture

		def initialize(attrs = {})
			@document 			= attrs[:document]
			@company 			= attrs[:company]
			@transaction_amount = attrs[:amount].to_f
			@token 				= attrs[:token]
			@description 		= attrs[:description]
			@payer 				= attrs[:payer]
			@installments 		= attrs[:installments].to_i
			@payment_method_id 	= attrs[:payment_method_id]
			@issuer_id 			= attrs[:issuer_id]
			@capture			= attrs[:capture].nil? ? true : false

			if !@company.nil?
				@application_fee 	= (@transaction_amount * @company.transaction_fee).round(2)
				@mp = MercadoPago.new(@company.mp_access_token)
			else
				@mp = MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
			end
			
		end

		def send_payment
			if capture
				data = set_payment_data
			else
				data = set_authorization_data
			end
			pp data
			return mp.post("/v1/payments", data)
		end

		def set_payment_data
			paymentData = Hash[
				"transaction_amount" => transaction_amount,
				"token" => token,
				"description" => description,
				"payer" => payer,
				"installments" => installments,
				"payment_method_id" => payment_method_id,
				"issuer_id" => issuer_id,
				"application_fee" => application_fee,
				"capture" => true
			]
		end

		def set_authorization_data
			paymentData = Hash[
				"transaction_amount" => transaction_amount,
				"token" => token,
				"description" => description,
				"payer" => payer,
				"installments" => 1,
				"payment_method_id" => payment_method_id,
				"capture" => false
			]
		end

		def self.cancel_payment(payment_id)
			mp = MercadoPago.new(MercadoPagoTransaction.find(payment_id).company.mp_access_token)
			mp.cancel_payment(payment_id.to_s)
		end

		def self.partial_refound_payment(payment_id,partial_amount)
			mp = MercadoPago.new(MercadoPagoTransaction.find(payment_id).company.mp_access_token)
			mp.refund_payment(payment_id.to_s, partial_amount)
		end

		def self.refound_payment(payment_id)
			mp = MercadoPago.new(MercadoPagoTransaction.find(payment_id).company.mp_access_token)
			mp.refund_payment(payment_id.to_s)
		end

		def save_data(response)
		    initialize_payment(response)
		    MercadoPagoLocal::Card.new(company_id: @company.id, customer_email: payer["email"]).save_customer
		end

		def initialize_payment response
			mptran = MercadoPagoTransaction.create(
				id: 										response["id"],
				company_id: 								document.company_id,
				date_created: 								Date.today,
				description: 								"-",
				operation_type: 							response["operation_type"],
				transaction_amount: 						response["transaction_amount"],
				status: 									response["status"],
				installments:  								response["installments"],
				transaction_details_net_received_amount:  	response["transaction_details"]["net_received_amount"],
				transaction_details_total_paid_amount:  	response["transaction_details"]["total_paid_amount"],
				transaction_details_installment_amount:  	response["transaction_details"]["installment_amount"]

			)
		end

		def self.get_payment(id)
			mp 			= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
			response 	= mp.get("/v1/payments/#{id}")
			return response
		end

		def self.set_payment_attributes(response)
			response 	= response["response"]
			pp response
			r = response.try(:[], "refunds").last
			attributes 	= {
				"id" 										=> response["id"],
				"date_created"								=> response["date_created"],
				"date_approved" 							=> response["date_approved"],
				"collector_id" 								=> response["collector_id"],
				"description" 								=> response["description"] || "-",
				"currency_id" 								=> response["currency_id"],
				"operation_type" 							=> response["operation_type"],
				"transaction_amount" 						=> response["transaction_amount"],
				"transaction_amount_refunded" 				=> response["transaction_amount_refunded"],
				"status" 									=> response["status"],
				"status_detail" 							=> response["status_detail"],
				"application_fee" 							=> response["application_fee"],
				"payment_type_id" 							=> response["payment_type_id"],
				"payment_method_id" 						=> response["payment_method_id"],
				"card_id" 									=> response["card"]["id"],
				"installments" 								=> response["installments"],
				"transaction_details_net_received_amount" 	=> response["transaction_details"]["net_received_amount"],
				"transaction_details_total_paid_amount" 	=> response["transaction_details"]["total_paid_amount"],
				"transaction_details_installment_amount" 	=> response["transaction_details"]["installment_amount"],
				"refunds_id" 								=> r.try(:[], "id").to_i, 
				"refunds_payment_id" 						=> r.try(:[], "payment_id").to_i,
				"refunds_amount" 							=> r.try(:[], "amount").to_f,
				"refunds_source_id" 						=> r.try(:[], "source").try(:[], "id").to_s,
				"refunds_source_name" 						=> r.try(:[], "source").try(:[], "name").to_s,
				"refunds_date_created" 						=> r.try(:[], "date_created")
			}

			return attributes
			#save_transaction(mptran, document)
		end

		def self.save_transaction(mptran, document)
			if mptran.save && (not document.nil?)
				save_depending_document
			end
		end

		def self.save_depending_document
			case document.class.name
			when "Invoice"
				save_for_invoice
			when "Market Purchase"
				save_for_market_purchase
			end
		end

		def self.save_for_invoice
			if mptran.pcard.nil?
				pcard = Pcard.new(
					payment_type_id: 3,
					user_id: user_id,
					company_id: document.company_id,
					invoice_id: document.id,
					is_income: true,
					installments: 1,
					date: Date.today
				)
				if pcard.save
					mptran.update(pcard_id: pcard.id)
				end
			else
				mptran.update_pcard
			end
		end

		def self.save_for_market_purchse
			if mptran.pcard.nil?
				pcard = Pcard.new(
					payment_type_id: 3,
					user_id: user_id,
					company_id: document.company_id,
					market_purchase_id: document.id,
					is_income: true,
					installments: 1,
					date: Date.today
				)
				if pcard.save
					mptran.update(pcard_id: pcard.id)
				end
			else
				mptran.update_pcard_for_market_purchase
			end
		end

		def self.is_suscription? payment_info
			if not payment_info["response"]["metadata"].nil?
				return (not payment_info["response"]["metadata"]["subscription_id"].nil?)
			else
				return false
			end
		end
	end
end