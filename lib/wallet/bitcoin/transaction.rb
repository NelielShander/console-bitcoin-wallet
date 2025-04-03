module Wallet
  module Bitcoin
    class Transaction
      include Wallet::Utils

      attr_reader :inputs, :outputs
      attr_accessor :marker, :flag, :withess, :signed

      def initialize(legacy: true)
        @signed = false
        @legacy = legacy
        @inputs = []
        @outputs = []
        @marker = nil
        @flag = nil
        @withess = nil
      end

      def fields
        {
          version:,
          inputcount:,
          inputs: input_fields,
          outputcount:,
          outputs: output_fields,
          locktime:
        }
      end

      def raw_data
        raw = version
        raw += inputcount
        raw += inputs_raw
        raw += outputcount
        raw += outputs_raw
        raw + locktime
      end

      def version
        decimal = @legacy ? 1 : 2
        little_endian(decimal:, bytes: 4)
      end

      def inputcount
        compact_size @inputs.count
      end

      def input_fields
        @inputs.map(&:fields)
      end

      def outputcount
        compact_size @outputs.count
      end

      def output_fields
        @outputs.map(&:fields)
      end

      def locktime
        decimal = 0
        little_endian(decimal:, bytes: 4)
      end

      def inputs_raw
        inputs.map(&:raw_data).join
      end

      def outputs_raw
        outputs.map(&:raw_data).join
      end

      def txid
        hash256(raw_data)
      end

      def inputs_amount
        @inputs.map(&:amount).sum
      end

      def details
        @inputs.each_with_index do |input, index|
          $stdout.puts "input #{index}  = #{input.amount} satoshis"
        end

        $stdout.puts ''

        @outputs.each_with_index do |output, index|
          $stdout.puts "output #{index} = #{output.amount} satoshis"
        end

        fee = @inputs.map(&:amount).sum - @outputs.map(&:amount).sum
        $stdout.puts "fee      = #{fee} satoshis"
      end
    end
  end
end
