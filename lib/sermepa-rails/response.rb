module SermepaRails
  class Response < ActiveRecord::Base
    set_table_name :sermepa_responses
    validate :authentic?

    belongs_to :origin, :polymorphic => true

    before_create :asign_origin
    after_save :call_origin_callback

    def paid?
      cod = response_code
      cod >= 0 && cod <= 99
    end

    def amount
      Float(self.Ds_Amount)/100
    end

    def sum_total
      Float(self.Ds_SumTotal)/100
    end

    def currency
      CP_CURRENCY.invert[Integer(self.Ds_Currency)]
    end

    def datetime
      date = self.Ds_Date.split("/")
      hour = self.Ds_Hour.split(":")
      DateTime.civil_from_format(:local, date[2].to_i, date[1].to_i, date[0].to_i, hour[0].to_i, hour[1].to_i, hour[2].to_i)
    end

    def authorization_code
      self.Ds_AuthorisationCode
    end

    def secure_payment?
      self.Ds_SecurePayment == "1"
    end

    def term_num
      self.Ds_Terminal.to_i
    end

    def response_code
      self.Ds_Response.to_i
    end

    def error_code
      self.Ds_ErrorCode
    end

    def merchant_code
      self.Ds_MerchantCode
    end

    def language
      CP_LANGUAGE.invert[Integer(self.Ds_ConsumerLanguage)]
    end

    def order
      self.Ds_Order
    end

    def transaction_type
      CP_TRANSACTION_TYPE.invert[self.Ds_TransactionType]
    end

    def card_country
      CP_COUNTRY.invert[self.Ds_Card_Country.to_i]
    end

    def card_type
      CP_CARD_TYPE.invert[self.Ds_Card_Type]
    end

    def pay_method
      CP_PAYMENT_METHOD.invert[self.Ds_PayMethod]
    end

  private
    def authentic?
      key = "#{self.Ds_Amount}#{self.Ds_Order}#{self.Ds_MerchantCode}#{self.Ds_Currency}#{self.Ds_Response}"
      key << CYBERPAC_CONFIG['encrypt_key']
      errors.add(:base, "Signature do not match") unless self.Ds_Signature == SHA1.new(key).to_s.upcase
    end

    def asign_origin
      if self.Ds_MerchantData
        foo = self.Ds_MerchantData.split(".")
        self.origin_type = foo[0]
        self.origin_id = foo[1].to_i
      end
    end

    def call_origin_callback
      if origin.present?
        to_call = origin.get_response_callback
        origin.send(to_call, self)
      end
    end
  end
end

