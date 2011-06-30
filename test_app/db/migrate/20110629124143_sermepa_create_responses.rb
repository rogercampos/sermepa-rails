class SermepaCreateResponses < ActiveRecord::Migration
  def self.up
    create_table :sermepa_responses do |t|
      t.string  "Ds_AuthorisationCode"
      t.string  "Ds_Hour"
      t.string  "Ds_SecurePayment"
      t.string  "Ds_Terminal"
      t.string  "Ds_Response"
      t.string  "Ds_Currency"
      t.string  "Ds_ErrorCode"
      t.string  "Ds_MerchantCode"
      t.string  "Ds_Amount"
      t.string  "Ds_ConsumerLanguage"
      t.string  "Ds_Signature"
      t.string  "Ds_Order"
      t.string  "Ds_Date"
      t.string  "Ds_TransactionType"
      t.string  "Ds_MerchantData"
      t.string  "origin_type"
      t.integer "origin_id"
      t.string  "Ds_Card_Country"
      t.string  "Ds_Card_Type"
      t.string  "Ds_PayMethod"
      t.string  "Ds_SumTotal"
      t.string  "Ds_MerchantPartialPayment"
    end
  end

  def self.down
    drop_table :sermepa_responses
  end
end
