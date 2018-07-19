module MercadoPagoLocal
	class ResponseHandler
		attr_accessor :response, :payment
		attr_reader :response, :payment

		def initialize(attrs = {})
			@response = attrs[:response]
			@payment = attrs[:payment]
		end

		def decode
			case response['status']
			when '201'
				#payment.save_data(response['response'])
				return response_201
			when '400'
				return response_400
			else
				return "No pudimos procesar tu pago"
			end
		end

		def response_201
		    case response['response']['status']
		    	when 'rejected'
			        case response['response']['status_detail']
				        when 'cc_rejected_bad_filled_card_number'
				            message = 'Revisa el número de tarjeta.'
				        when 'cc_rejected_bad_filled_date'
				            message = 'Revisa la fecha de vencimiento.'
				        when 'cc_rejected_bad_filled_other'
				            message = 'Revisa los datos.'
				        when 'cc_rejected_bad_filled_security_code'
				            message = 'Revisa el código de seguridad.'
				        when 'cc_rejected_blacklist'
				            message = 'No pudimos procesar tu pago.'
				        when 'cc_rejected_call_for_authorize'
				            message = 'Debes llamar a tu banco proveedor de tarjeta y autorizar el pago a MercadoPago'
				        when 'cc_rejected_card_disabled'
				            message = 'Llama a tu banco para que active tu tarjeta. El teléfono está al dorso de tu tarjeta.'
				        when 'cc_rejected_card_error'
				            message = 'No pudimos procesar tu pago.'
				        when 'cc_rejected_duplicated_payment'
				            message = 'Ya hiciste un pago por ese valor. Si necesitas volver a pagar usa otra tarjeta u otro medio de pago.'
				        when 'cc_rejected_high_risk'
				            message = 'Tu pago fue rechazado. Elige otro de los medios de pago, te recomendamos con medios en efectivo.'
				        when 'cc_rejected_insufficient_amount'
				            message = 'No tienes fondos suficientes.'
				        when 'cc_rejected_invalid_installments'
				            message = 'Cantidad de cuotas invalida.'
				        when 'cc_rejected_max_attempts'
				            message = 'Llegaste al límite de intentos permitidos.'
				        when 'cc_rejected_other_reason'
				            message = 'No se pudo procesar el pago. Intente nuevamente con otra tarjeta.'
				        else
				            message = 'Error, no se pudo concretar el pago.'
			        end
			    when 'approved'
			    	message = '¡Listo, se acreditó tu pago!'
			    when 'in_process'
			    	case response['response']['status_detail']
				    	when 'pending_contingency'
				    		message = 'El pago demorará demasiado tiempo en procesarse para esta tarjeta, por lo tanto se cancelara. Intenta nuevamente con otra tarjeta'
				    	when 'pending_review_manual'
				    		message = 'El pago demorará demasiado tiempo en procesarse para esta tarjeta, por lo tanto se cancelara. Intenta nuevamente con otra tarjeta'
			    	end
		    end
		    return message
		end #response_201

		def response_400
			case response['code']
				when '106'
					message = 'No puedes realizar pagos a usuarios de otros países.'
				when '109'
					message = 'Tu tarjeta no procesa pagos esa cantidad de cuotas. Elige otra tarjeta u otro medio de pago.'
				when '126'
					message = 'No pudimos procesar tu pago.'
				when '129'
					message = 'Tu tarjeta no procesa pagos del monto seleccionado. Elige otra tarjeta u otro medio de pago.'
				when '145'
					message = 'No pudimos procesar tu pago.'
				when '150'
					message = 'No puedes realizar pagos.'
				when '151'
					message = 'No puedes realizar pagos.'
				when '160'
					message = 'No pudimos procesar tu pago.'
				when '204'
					message = 'Tu tarjeta  no está disponible en este momento. Elige otra tarjeta u otro medio de pago.'
				when '801'
					message = 'Realizaste un pago similar hace instantes. Intenta nuevamente en unos minutos.'
				else
					message = 'No pudimos procesar tu pago.'
			end
		end #response_400

	end
end