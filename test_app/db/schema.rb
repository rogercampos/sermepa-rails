# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110629124143) do

  create_table "sermepa_responses", :force => true do |t|
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
