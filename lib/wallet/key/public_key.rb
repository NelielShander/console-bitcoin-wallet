require 'ecdsa'

module Wallet
  module Key
    class PublicKey
      include Wallet::Utils

      attr_reader :point

      def initialize(private_key:, compression: true)
        @private_key = private_key
        @compression = compression
        @point = new_point(@private_key)
      end

      def hex
        uniq_bytes.unpack('H*').join
      end

      def uniq_bytes
        ECDSA::Format::PointOctetString
          .encode(@point, compression: @compression)
      end

      private

      def new_point(private_key)
        private_key.decimal
          .then { |decimal| group.multiply_by_scalar(decimal) }
      end

      def group
        ECDSA::Group::Secp256k1.generator
      end
    end
  end
end
