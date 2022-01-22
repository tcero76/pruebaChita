# README

Prueba:

http://127.0.0.1:3000/calculo?client_dni=76329692-K&debtor_dni=77360390-1&document_amount=1000000&folio=75&expiration_date=2022-08-13

api de Chita entrega los siguientes valores:
{
    "document_rate": 0.89,
    "commission": 0.0,
    "advance_percent": 99.0
}

Resultado que entrega mi aplicación:

{
    "financial_cost": "60208.4999999999934",
    "money_receive": "929791.5000000000066",
    "surplus": "10000.0"
}

Controller: [enlace](https://github.com/tcero76/pruebaChita/blob/master/app/controllers/calculo_controller.rb)

Test: [enlace](https://github.com/tcero76/pruebaChita/blob/master/test/controllers/calculo_controller_test.rb)