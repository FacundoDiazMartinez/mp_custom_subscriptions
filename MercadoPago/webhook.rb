module MercadoPagoLocal
	class WebHook
		attr_reader	  :mp
		attr_accessor :type, :date_created, :action, :id, :access_token, :data_id

		def initialize ( attrs = {} )
			@type 			= attrs[:type]
			@date_created 	= attrs[:date_created]
			@action 		= attrs[:action]
			@id 			= attrs[:id]
			@data_id		= attrs[:data_id]
			@access_token 	= attrs[:access_token]

			@mp 			= MercadoPago.new(ENV["MERCADOPAGO_CLIENT_ID"], ENV["MERCADOPAGO_CLIENT_SECRET"])
		end

	end
end