require 'MercadoPagoLocal.rb'
MercadoPagoLocal.setup do |config|
	#Name of the company that will appear in the suscriptions mails.
	config.business_name = "Nombre de tu empresa acá."
	#mail that will appear in the mails.
	config.mail_from = "admin@admin.com"
end