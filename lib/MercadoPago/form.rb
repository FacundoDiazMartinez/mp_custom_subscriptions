module MercadoPagoLocal
	class Form
		include ActionView::Helpers::FormHelper

		def initialize(attrs={})
			@type					= attrs[:type] || "payment"
			@mercadopago_public_key = attrs[:mercadopago_public_key]
			@form_path 				= attrs[:form_path]
		end
           
	    def set_form
            MercadoPagoLocal::FormHelper.set_form_helper
        end 
	end
end