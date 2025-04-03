module Wallet
  module Bitcoin
    class Output
      include Wallet::Utils

      attr_reader :amount, :scriptpubkey

      def initialize(amount:, scriptpubkey:)
        @amount = amount
        @scriptpubkey = scriptpubkey
      end

      def fields
        {
          amount: output_value,
          scriptpubkeysize:,
          scriptpubkey:
        }
      end

      def raw_data
        raw = output_value
        raw += scriptpubkeysize
        raw + scriptpubkey
      end

      def output_value
        little_endian(decimal: @amount, bytes: 8)
      end

      def scriptpubkeysize
        decimal = bytesize(@scriptpubkey)
        compact_size(decimal)
      end
    end
  end
end
