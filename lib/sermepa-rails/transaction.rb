module SermepaRails
  class Transaction
    attr_reader :amount
    attr_reader :notify_url
    attr_reader :order
    attr_reader :concept
    attr_reader :titular
    attr_reader :transaction_type
    attr_reader :fuc
    attr_reader :term_number
    attr_reader :currency
    attr_reader :url_ok
    attr_reader :url_error
    attr_reader :merchant_name
    attr_reader :language
    attr_reader :extra_data
    attr_reader :pay_methods
    attr_reader :date_frequency
    attr_reader :charge_expiry_date
    attr_reader :sum_total
    attr_reader :origin

    def initialize(opts)
      raise ArgumentError, "Order number is mandatory" unless opts[:order]
      raise ArgumentError, "Amount is mandatory" unless opts[:amount]
      raise ArgumentError, "Concept is mandatory" unless opts[:concept]
      raise ArgumentError, "Titular is mandatory" unless opts[:titular]
      raise ArgumentError, "Transaction Type is mandatory" unless opts[:transaction_type]
      raise ArgumentError, "Origin is mandatory" unless opts[:origin]

      notify_url = opts[:notify_url] || CYBERPAC_CONFIG['notify_url']
      url_ok = opts[:url_ok] || CYBERPAC_CONFIG['url_ok']
      url_error = opts[:url_error] || CYBERPAC_CONFIG['url_error']

      @notify_url = validate_url "Notification URL", notify_url
      @url_ok = validate_url "Correct returning URL", url_ok
      @url_error = validate_url "Error returning URL", url_error
      @order = validate_order opts[:order]
      @amount = validate_amount opts[:amount]
      @concept = validate_concept opts[:concept]
      @titular = validate_titular opts[:titular]
      @transaction_type = validate_transaction_type opts[:transaction_type]
      @origin = opts[:origin]

      @fuc = validate_fuc CYBERPAC_CONFIG['fuc']
      @term_number = validate_term_number CYBERPAC_CONFIG['term_number']
      @currency = validate_currency CYBERPAC_CONFIG['term_currency']

      @merchant_name = validate_merchant_name(opts[:merchant_name]) if opts[:merchant_name]
      language = validate_language(opts[:lang]) if opts[:lang]
      @extra_data = validate_extra_data(opts[:extra_data].to_s) if opts[:extra_data]
      @pay_methods = validate_pay_methods(opts[:pay_methods]) if opts[:pay_methods]

      @date_frequency = opts[:date_frequency] if opts[:date_frequency]
      @charge_expiry_date = validate_expiry_date(opts[:charge_expiry_date]) if opts[:charge_expiry_date]
      @sum_total = validate_amount opts[:sum_total] if opts[:sum_total]

      # for transaccions recurrents validar: sum_total, :date_frecuency, :charge_Expiry_date
    end

    def signature
      raise ArgumentError, "Key type must be :complete or :expanded" unless [:complete, :expanded].include?(CYBERPAC_CONFIG['key_type'])
      key = "#{@amount}#{@order}#{@fuc}#{@currency}"
      if @transaction_type == "5" && @sum_total
        key << @sum_total
      end
      if CYBERPAC_CONFIG['key_type'] == :expanded
        key << "#{@transaction_type}#{@notify_url}"
      end
      key << CYBERPAC_CONFIG['encrypt_key']
      SHA1.new(key).to_s
    end

  private
    def validate_fuc(fuc)
      fuc = fuc.to_s
      unless fuc.length <= 9 && fuc =~ /^\d+$/
        raise ArgumentError, "FUC invalid format"
      end
      fuc
    end

    def validate_term_number(term_num)
      term_num = term_num.to_s
      unless term_num.length <= 3 && term_num =~ /^\d+$/
        raise ArgumentError, "Terminal number invalid format"
      end
      term_num
    end

    def validate_currency(name)
      code = CP_CURRENCY[name.to_sym]
      raise ArgumentError, "Currency #{name} doest not exists" unless code
      code.to_s
    end

    def validate_order(order)
      order = order.to_s
      unless order.length <= 12 && order =~ /^\d{4,}[\da-zA-Z]*$/
        raise ArgumentError, "Order number #{order} not valid"
      end
      order
    end

    def validate_amount(amount)
      begin
        amount = Float(amount)
      rescue
        raise ArgumentError, "Amount must be a number"
      end
      (amount * 100).truncate.to_s
    end

    def validate_transaction_type(ttype)
      code = CP_TRANSACTION_TYPE[ttype.to_sym]
      raise ArgumentError, "Transaction type #{ttype} does not exists" unless code
      code
    end

    def validate_concept(concept)
      raise ArgumentError, "Concept invalid (max 125 characters)" if concept.to_s.length > 125
      concept.to_s
    end

    def validate_titular(titular)
      raise ArgumentError, "Titular invalid (max 60 characters)" if titular.to_s.length > 60
      titular.to_s
    end

    def validate_url(name, url)
      url = url.to_s
      unless url.length <= 250 && url =~ /^(http|https):\/\//
        raise ArgumentError, "#{name} invalid (250 characters and must be a properly formatted url)"
      end
      url
    end

    def validate_merchant_name(name)
      unless name.to_s.length <= 25
        raise ArgumentError, "Merchant name is not valid: #{name}"
      end
      name.to_s
    end

    def validate_language(lang)
      unless CP_LANGUAGE[lang.to_sym]
        raise ArgumentError, "Language not valid: #{lang}"
      end
      CP_LANGUAGE[lang.to_sym].to_s.rjust(3, "0")
    end

    def validate_extra_data(data)
      unless data.length < 1024
        raise ArgumentError, "Extra data < 1024 characters"
      end
      data
    end

    def validate_pay_methods(methods)
      methods = [methods] unless methods.kind_of? Array
      res = String.new
      methods.each do |x|
        raise ArgumentError, "Payment method not supported #{x}" unless CP_PAYMENT_METHOD.keys.include?(x.to_sym)
        res << CP_PAYMENT_METHOD[x.to_sym]
      end
      res
    end

    def validate_expiry_date(date)
      if date.respond_to? :to_date
        date = date.to_date
      elsif date.is_a?(String) && date =~ /^\d\d\d\d-\d\d-\d\d$/
        date = Date.new(date[0..3].to_i, date[5..6].to_i, date[8..9].to_i)
      else
        raise ArgumentError, "Expiry date is not a date: #{date}"
      end

      raise ArgumentError, "Expiry date must be one day in the future at least" unless date.future?
      "#{date.year}-#{date.month.to_s.rjust(2, '0')}-#{date.day.to_s.rjust(2, '0')}"
    end
  end
end

