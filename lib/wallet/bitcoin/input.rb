module Wallet
  module Bitcoin
    class Input
      include Wallet::Utils

      attr_accessor :scriptsig

      def initialize(utxo:, scriptsig: '')
        @utxo = utxo
        @scriptsig = scriptsig
      end

      def fields
        {
          txid:,
          vout:,
          scriptsigsize:,
          scriptsig:,
          sequence:
        }
      end

      def raw_data
        raw = txid
        raw += vout
        raw += scriptsigsize
        raw += scriptsig
        raw + sequence
      end

      def txid
        @utxo['txid']
      end

      def vout
        decimal = @utxo['vout']
        little_endian(decimal:, bytes: 4)
      end

      def scriptsigsize
        decimal = bytesize(@scriptsig)
        compact_size decimal
      end

      def sequence
        'ffffffff'
      end

      def amount
        @utxo['value']
      end
    end
  end
end
