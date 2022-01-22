require "test_helper"

class CalculoControllerTest < ActionDispatch::IntegrationTest
    test "Verificar resultados" do
        get "/calculo?client_dni=76329692-K&debtor_dni=77360390-1&document_amount=1000000&folio=75&expiration_date="+(Date.today+204).to_s
        res = JSON.parse(@response.body)
        assert_equal 6020850, res["financial_cost"].to_d.round(1)
        assert_equal -5030850, res["money_receive"].to_d.round(1)
        assert_equal 10000.0, res["surplus"].to_d.round(1)
    end
end