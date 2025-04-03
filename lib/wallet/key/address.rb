module Wallet
  module Key
    class Address
      include Wallet::Utils

      def initialize(hash160)
        @hash160 = hash160
        @prefix = Wallet.chain_params.address_version
        @checksum = checksum(@prefix + @hash160)
      end

      def hex
        hex = @prefix + @hash160 + @checksum
        base58_encode(hex)
      end
    end
  end
end
