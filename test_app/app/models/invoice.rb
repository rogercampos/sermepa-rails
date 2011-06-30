class Invoice
  include Sermepa::Rails::Base

  def sermepa_order
    "2412WCA00001"
  end

  def sermepa_amount
    50
  end

  def sermepa_concept
    "My teddy bear"
  end
end
