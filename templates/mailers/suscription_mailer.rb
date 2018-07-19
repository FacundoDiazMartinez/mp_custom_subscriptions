class SuscriptionMailer < ApplicationMailer

	def welcome user
		mail to: user.email, subject: "¡Bienvenido a #{::MercadoPagoLocal.business_name}!", from: "#{::MercadoPagoLocal.mail_from}"
	end

	def problem_with_suscription user
		mail to: user.email, subject: "Tenemos un problema para procesar tu pago.", from: "#{::MercadoPagoLocal.mail_from}"
	end

	def welcome_again user
		mail to: user.email, subject: "¡Bienvenido nuevamente a #{::MercadoPagoLocal.business_name}!", from: "#{::MercadoPagoLocal.mail_from}"
	end
end