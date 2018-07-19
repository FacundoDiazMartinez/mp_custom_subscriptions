require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('mp_custom_subscriptions', '0.1.0') do |p|
  p.description    = "Customized MP subscriptions gem."
  p.url            = "http://github.com/FacundoDiazMartinez/mp_custom_subscriptions"
  p.author         = "Ing. Facundo A. Díaz Martínez"
  p.email          = "facundodiazmartinez@icloud.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }