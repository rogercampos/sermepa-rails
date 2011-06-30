module Sermepa
  module Rails
    module ActiveRecordExtensions
      module ClassMEthods
        def sermepable
          has_many :sermepa_responses, :as => :origin, :class_name => "Sermepa::Rails::Response"
          include InstanceMethods unless included_modules.include?(InstanceMethods)
        end
      end

      module InstanceMethods
        def get_transaction
          Sermepa::Rails::Transaction.new({ :origin => self,
                                            :order => sermepa_order,
                                            :amount => sermepa_amount,
                                            :concept => sermepa_concept,
                                            :pay_methods => [:card, :transfer],
                                            :titular => "My company",
                                            :transaction_type => :auth,
                                            :extra_data => "#{self.class.to_s}.#{id}"})
        end
      end
    end
  end
end

ActiveRecord::Base.extend Sermepa::Rails::ActiveRecordExtensions::ClassMethods
