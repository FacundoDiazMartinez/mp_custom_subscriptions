module MercadoPagoHelper

	def set_form_helper path
		@path = path
		content_tag :div, class: "row" do
			concat(javascript_include_tag "https://secure.mlstatic.com/sdk/javascript/v1/mercadopago.js")
			concat(javascript_events)
			concat(payment_form)
		end
	end

	def javascript_events
		javascript_include_tag "mercadopago_init_form.js"
		javascript_include_tag "mercado_pago.js"
	end

	def payment_form
		form_tag @path, id: "payment_form", name: "payment_form" do
			concat(col_div)
			concat(submit_tag "Guardar", class: "btn btn-primary btn-lg")
		end
	end

	def col_div
		content_tag :div, class: "col-xs-6 col-md-12" do
			["amount", "card_number", "security_code", "card_expiration", "cardholder_name", "doc_type", "doc_number", "issuer", "installments"].each do |input|
				concat(form_groups(input))
			end
		end
	end

	def form_groups input
		content_tag :div, class: "form-group" do
			method(input).call
		end
	end

	def amount
		concat(label_tag :mp_amount, "Monto a pagar:", class: 'control-label')
		concat(number_field_tag :mp_amount, 0.0, step:"0.01",  class: 'form-control', required: true)
	end

	def card_number
		concat(label_tag "cardNumber", "Número de tarjeta de crédito:", class: "control-label")
		concat(number_field_tag "cardNumber", nil, class: "form-control", required: true, data:{checkout: "cardNumber"})
		concat(image_tag "https://imgmp.mlstatic.com/org-img/banners/ar/medios/785X40.jpg", id: "banner", width: "100%", style: "max-height: 40px;")
	end

	def security_code
		concat(label_tag "securityCode", "Código de seguridad:", class: "control-label")
		concat(number_field_tag "securityCode", nil, class: "form-control", required: true, data:{checkout: "securityCode"})
	end

	def card_expiration
		content_tag :div, class: "form-inline" do
			concat(expiration_month)
			concat(expiration_year)
		end
	end

	def expiration_month
		content_tag :div, class: "form-group" do
			concat(label_tag "cardExpirationMonth", "Fecha de expiración", class: "control-label")
			concat(select_tag "cardExpirationMonth", options_for_select((1..12).map{|m| m}), {required: true, data:{checkout: "cardExpirationMonth"}, class: 'form-control'})
		end
	end

	def expiration_year
		content_tag :div, class: "form-group" do
			concat(label_tag "cardExpirationYear", "",class: "control-label")
			concat(select_tag "cardExpirationYear", options_for_select(((Time.now.year)..(Time.now.year + 20)).map{|m| m}), {required: true, data:{checkout: "cardExpirationYear"}, class: 'form-control'})
		end
	end

	def cardholder_name
		concat(label_tag "cardholderName", "Nombre del titular:", class: "control-label")
		concat(text_field_tag "cardholderName", nil, class: "form-control", required: true, data:{checkout: "cardholderName"})
	end

	def doc_type
		concat(label_tag "docType", "Número de documento:", class: "control-label")
		concat(select_tag "docType", [], {required: true, class: 'form-control', data:{checkout: "docType"}})
	end

	def doc_number
		concat(label_tag "docNumber", "Número de documento:", class: "control-label")
		concat(text_field_tag "docNumber", nil, class: "form-control", required: true, data:{checkout: "docNumber"})
	end

	def issuer
		concat(label_tag "issuer", "Proveedor de tarjeta:", class: "control-label", id: "label_issuer")
		concat(select_tag "issuer", [], {required: true, class: 'form-control', data:{checkout: "issuer"}})
	end

	def installments
		concat(label_tag "installments", "Cuotas:", class: "control-label")
		concat(select_tag "installments", [], {required: true, class: 'form-control', data:{checkout: "installments"}})
	end
end