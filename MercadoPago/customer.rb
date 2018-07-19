module MercadoPagoLocal
	class Customer
		attr_reader	  :customers
		attr_accessor :customers, :mp

		def self.search_customer email
			@mp 		 ||= MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			@customers 	   = @mp.get("/v1/customers/search", Hash["email" => email])
		end

		def self.customer_exist? email
			response = search_customer(email)
			if response["status"] == "200"
				if response["response"]["paging"]["total"] >= 1
					return true
				else
					return false
				end
			else
				return false
			end
		end

		def self.set_customer email
			@mp  = MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			@mp.post("/v1/customers", Hash["email" => email])
		end

		def self.get_customer_id email
			@mp ||= MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			if customer_exist?(email)
				@customers["response"]["results"].first["id"]
			else
				save_customer_in_company(email)
			end
		end

		def self.save_customer_in_company email
			response 	= set_customer(email)
			client 		= ::User.find_by_email(email)
			company 	= client.company
			pp company.update(customer_id: response["response"]["id"])
			return response["response"]["id"]
		end

		def self.set_card_to_customer customer_id, token
			@mp ||= MercadoPago.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
			@mp.post("/v1/customers/#{customer_id}/cards", Hash["token" => token])
		end
	end
end