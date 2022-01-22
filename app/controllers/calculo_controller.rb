class CalculoController < ApplicationController

    def calcular
        client_dni=params["client_dni"]
        debtor_dni=params["debtor_dni"]
        document_amount=params["document_amount"].to_d
        folio=params["folio"]
        expiration_date=Date.parse(params["expiration_date"])
        uri = URI("https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{client_dni}&debtor_dni=#{debtor_dni}&document_amount=#{document_amount}&folio=#{folio}&expiration_date=#{expiration_date.to_s}")
        req = Net::HTTP::Get.new(uri)
        req['X-Api-Key'] = "UVG5jbLZxqVtsXX4nCJYKwtt"
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
          http.request(req)
        }
        json = JSON.parse(res.body)
        pp json
        #Costo de financiamiento (costo de operar la factura con nosotros) = (Monto de la factura * Porcentaje de anticipo) * (Tasa de Negocio / 30 * Días de plazo[Días corridos desde hoy hasta la fecha de vencimiento + 1 dia extra])
        financial_cost = (document_amount * json["advance_percent"]/100) * ((json["document_rate"]/100)/30*(expiration_date-Date.today).to_i)
        #Giro a recibir = (1000000 * (99.0/100)) - (1000000 * (99.0 / 100) * ((1.9/100) / 30 * 31)) - (23990)
        money_receive = (document_amount * (json["advance_percent"]/100)) - ( financial_cost + json["commission"])
        #Excedentes = 1000000 - (1000000 * (99.0/100))
        surplus = document_amount-(document_amount*(json["advance_percent"]/100))
        render json: {
                        "financial_cost": financial_cost,
                        "money_receive": money_receive,
                        "surplus": surplus
                    }
    end

end
