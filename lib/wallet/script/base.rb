module Wallet
  module Script
    class Base
      include Wallet::Utils

      OPCODES = {
        'OP_0' => '0x00',
        'OP_CHECKSIG' => '0xac',
        'OP_DUP' => '0x76',
        'OP_EQUALVERIFY' => '0x88',
        'OP_HASH160' => '0xa9',
        'OP_PUSHBYTES_20' => '0x14',
        'OP_PUSHBYTES_33' => '0x21',
        'OP_PUSHBYTES_71' => '0x47',
        'OP_PUSHBYTES_72' => '0x48'
      }

      def scriptpubkey
        scriptpubkey_asm.split(' ')
          .map { |string| encode(string) }
          .join
      end

      def scriptsig
        scriptsig_asm.split(' ')
          .map { |string| encode(string) }
          .join
      end

      def encode(opcode_or_hex)
        if opcode_or_hex[0..2] == 'OP_'
          OPCODES[opcode_or_hex][2..]
        else
          opcode_or_hex
        end
      end

      def scriptpubkey_asm
        raise NotImplementedError
      end

      def scriptsig_asm
        raise NotImplementedError
      end
    end
  end
end
