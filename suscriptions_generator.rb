class SuscriptionsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_mailers
  	copy_file "mailers/suscription_mailer.rb", "app/mailers/suscription_mailer.rb"
  	copy_file "/lib//MercadoPagoLocal.rb", "lib/MercadoPagoLocal.rb"
  	directory "views/suscription_mailers", "app/views/suscription_mailer"
  	copy_file "helpers/mercado_pago_helper.rb", "app/helpers/mercado_pago_helper.rb"
  	copy_file "assets/javascripts/mercado_pago.js", "public/javascripts/mercado_pago.js"
  	copy_file "config/initializers/mercado_pago_local.rb", "config/initializers/mercado_pago_local.rb"
  	directory "/lib/MercadoPago", "lib/MercadoPago"
  	template  "views/layouts/mailer.html.erb", "app/views/layouts/mailer.html.erb"
  end

end
