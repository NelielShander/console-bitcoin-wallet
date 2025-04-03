module Wallet
  module Script
    class PayToWitnessPublicKeyHash < Base
      def initialize(public_key_hash: nil, signature: nil, public_key: nil)
        @public_key_hash = public_key_hash
        @public_key = public_key
        @signature = signature
      end

      def scriptpubkey_asm
        "OP_0 OP_PUSHBYTES_20 #{@public_key_hash}"
      end

      def scriptsig_asm
        "#{@signature} #{@public_key}"
      end
    end
  end
end
