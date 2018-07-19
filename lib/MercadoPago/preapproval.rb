module MercadoPagoLocal
	class Preapproval
		attr_reader   :mp, :amount, :customers
		attr_accessor :user, :name

		def initialize ( attrs = {} )
		  	@user 						= attrs[:user]
		  	@name						= attrs[:name]
			@mp 						= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"]) #MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
		end

		def new_preapproval
		    pp set_amount
		    pp preapproval_data
		    pp result = mp.create_preapproval_payment(preapproval_data)
		    return result
		end

		def preapproval_data 
			Hash[
		      "payer_email" => user.email,
		      "back_url" => "http://www.desideral.com/suscription",
		      "reason" => "Suscripción mensual - Plan #{name}",
		      "external_reference" => "#{name}",
		      "auto_recurring" => Hash[
		        "frequency" => 1,
		        "frequency_type" => "months",
		        "transaction_amount" => amount,
		        "currency_id" => "ARS",
		        "start_date" => "#{(Time.now + 1.hours).to_time.iso8601(3)}"
		      ]
		    ]
		end

		def set_amount
		    case name
		      when "Profesional"
		        @amount = 2
		      when "Customizado"
		        @amount = 3
		      else 
		    	@amount = 2
		    end
		end


		def self.save_preapproval response
			if response["status"] == "200" || response["status"] == "201"
				if response["response"]["status"] != "pending"
					preapproval = Preapproval.first_or_init_preapproval(response)
					Preapproval.check_state(preapproval)
					return preapproval
				end
			end
		end

		def self.first_or_init_preapproval response
			user = ::User.where(email: response["response"]["payer_email"]).first
			if not user.nil?
				preapproval = user.suscriptions.where(suscription_id: response["response"]["id"]).first_or_initialize
			    preapproval.suscription_id 		= response["response"]["id"]
			    preapproval.payer_id 			= response["response"]["payer_id"]
			    preapproval.payer_email 		= response["response"]["payer_email"]
			    preapproval.status 				= response["response"]["status"]
			    preapproval.description 		= response["response"]["reason"]
			    preapproval.external_references	= response["response"]["external_reference"]
			    preapproval.date_created 		= response["response"]["date_created"]
			    preapproval.last_modified 		= response["response"]["last_modified"]
				preapproval.save
				return preapproval
			end
		end

		def self.check_state preapproval
			user = preapproval.user
			#Cuando el preapproval no esta pagado
			if preapproval.status != "authorized" #&& (preapproval.created_at + 1.months  - 5.hours) < Time.now
				::SuscriptionMailer.card_issues(preapproval).deliver_later
				Preapproval.set_unpaid_preapproval(preapproval)
				preapproval.destroy
			else #Cuando si esta pagado
				Preapproval.set_paid_preapproval(preapproval)
			end
		end

		def self.set_unpaid_preapproval preapproval
			user = preapproval.user
			user.update(paid: false)
			user.company.update(paid: false, suscription_type: "Basico")
		end

		def self.set_paid_preapproval preapproval
			user = preapproval.user
			user.update(paid: true)
			user.company.update(paid: true, suscription_type: preapproval.external_references.to_s)
		end

		def self.cancel_preapproval preapproval_id
			mp = MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			mp.put("/preapproval/#{preapproval_id}", Hash["status" => "paused"])
		end

		def self.save_authorized_payment response
			if response["status"] == "200" || response["status"] == "201"
				preapproval = Suscription.where(suscription_id: response["response"]["preapproval_id"]).first
				if response["response"]["status"] == "recycling" || response["response"]["status"] == "cancelled"
					::SuscriptionMailer.card_issues(preapproval).deliver_now
					Preapproval.set_unpaid_preapproval(preapproval)
				else
					Preapproval.set_paid_preapproval(preapproval)
				end
			end
		end
	end
end

		