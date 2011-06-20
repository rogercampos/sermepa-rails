Sermepa-Rails
=============

It's a simple implementation for the spanish sermepa payment integration
system.


Configuration
=============

Yo need to specify your


Usage
=====
    class Invoice < ActiveRecord::Base
      sermepa_pageable :amount => :total,
                       :concept => :concept,
                       :titular => "Itnig S.L."
                       :on_response => :verify_payment

      def verify_payment(response)
        self.bill! if response.paid?
      end
    end

    <%= sermepa_form(@invoice) %>

    <%= sermepa_form(@invoice.get_sermepa_transaction(:concept => "Otro")) %>


    @invoice.sermepa_responses # => All received responses for this object
