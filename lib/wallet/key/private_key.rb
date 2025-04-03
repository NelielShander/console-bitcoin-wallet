require 'securerandom'

module Wallet
  module Key
    class PrivateKey
      include Wallet::Utils

      RANGE = 1..115_792_089_237_316_195_423_570_985_008_687_907_852_837_564_279_074_904_382_605_163_141_518_161_494_336

      attr_reader :decimal

      def initialize(hex: nil)
        @decimal = hex ? hex_to_decimal(hex) : random_number
      end

      def hex
        decimal_to_hex @decimal
      end

      private

      def random_number
        SecureRandom.random_number(RANGE)
      end
    end
  end
end
