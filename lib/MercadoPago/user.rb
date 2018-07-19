module MercadoPagoLocal

	class User
		attr_accessor :company
		attr_reader :company

		def initialize(attrs ={})
			@company = Company.find(attrs[:company].to_i) ||  raise(NullOrInvalidAttribute.new, "ID de Compañía no ingresado.") 
		end

		def is_logged_in?
			!(company.mp_access_token.blank? || company.mp_public_key.blank?) &&
			!(company.mp_registered_in + company.mp_expires_in <= Time.now.to_i)
		end
	end
end