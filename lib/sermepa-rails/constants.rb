module Sermepa
  module Rails
    CP_TRANSACTION_TYPE = {
                  :auth => "0",
                  :pre_auth => "1",
                  :confirmation => "2",
                  :auto_refund => "3",
                  :reference_payment => "4",
                  :recurrent_transaction => "5",
                  :scheduled_transaction => "6",
                  :authentication => "7",
                  :confirm_authentication => "8",
                  :cancel_pre_auth => "9",
                  :difer_auth => "O",
                  :confirm_difer_auth => "P",
                  :cancel_difer_auth => "Q",
                  :auth_initial_difer_recurrent => "R",
                  :auth_initial_difer_scheduled => "S"
                          }

    # ISO 4217
    CP_CURRENCY = {
                  :eur => 978,
                  :gbp => 826,
                  :usd => 840
                  }

    # ISO 639-1
    CP_LANGUAGE = {
                  :es => 1,
                  :en => 2,
                  :ca => 3,
                  :fr => 4,
                  :de => 5,
                  :holandes => 6,
                  :it => 7,
                  :sv => 8,
                  :pr => 9,
                  :valenciano => 10,
                  :pl => 11,
                  :gallego => 12,
                  :eu => 13
                  }

    CP_CARD_TYPE = { :credit => "C", :debit => "D" }

    # http://unstats.un.org/unsd/methods/m49/m49alpha.htm
    CP_COUNTRY = { :spain => 724 }

    CP_PAYMENT_METHOD = { :card => "T", :transfer => "R", :direct_billing => "D" }
  end
end
