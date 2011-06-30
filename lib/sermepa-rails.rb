require 'digest/sha1'

module Sermepa
  module Rails
    mattr_accessor :ok_url
    mattr_accessor :error_url
    mattr_accessor :notify_url
    mattr_accessor :api_url
    mattr_accessor :fuc
    mattr_accessor :term_number
    mattr_accessor :term_currency
    mattr_accessor :key_type
    mattr_accessor :encrypt_key

    @@api_url = "https://sis-t.sermepa.es:25443/sis/realizarPago"
    @@term_currency = "eur"
    @@key_type = :expanded

    def self.configure
      yield self
    end
  end
end

require 'sermepa-rails/engine' if defined? ::Rails
require 'sermepa-rails/constants'
require 'sermepa-rails/response'
require 'sermepa-rails/transaction'
