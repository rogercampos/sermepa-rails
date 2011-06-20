require 'sha1'
require 'activerecord'

module SermepaRails
  mattr_accessor :ok_url
  mattr_accessor :error_url
  mattr_accessor :api_url
  mattr_accessor :fuc
  mattr_accessor :term_number
  mattr_accessor :term_currency
  mattr_accessor :key_type
  mattr_accessor :encrypt_key

  @@ok_url = root_url
  @@error_url = root_url
  @@api_url = "https://sis-t.sermepa.es:25443/sis/realizarPago"
  @@term_currency = "eur"
  @@key_type = :expanded

  def self.configure
    yield self
  end
end

require 'sermepa-rails/engine' if defined? Rails
