module Wallet
  module Script
    class PayToPublicKeyHash < Base
      def initialize(public_key_hash: nil, signature: nil, public_key: nil)
        @public_key_hash = public_key_hash
        @public_key = public_key
        @signature = signature
      end

      def scriptpubkey_asm
        "OP_DUP OP_HASH160 #{@public_key_hash} OP_EQUALVERIFY OP_CHECKSIG"
      end

      def scriptsig_asm
        "OP_PUSHBYTES_72 #{@signature} OP_PUSHBYTES_33 #{@public_key}"
      end
    end
  end
end
