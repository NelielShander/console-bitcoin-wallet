require 'digest'
require 'base58'
require 'bech32'
require 'ecdsa'
require 'digest/sha2'

module Wallet
  module Utils
    def hex_to_decimal(hex)
      hex.to_i(16)
    end

    def decimal_to_hex(decimal)
      decimal.to_s(16)
    end

    def bytesize(hex)
      [hex].pack('H*').size
    end

    def hash256(hex)
      [hex].pack('H*')
        .then { |binary| Digest::SHA256.digest(binary) }
        .then { |hash1| Digest::SHA256.digest(hash1) }
        .then { |hash2| hash2.unpack('H*') }
        .first
    end

    def hash160(hex)
      [hex].pack('H*')
        .then { |binary| Digest::SHA256.digest(binary) }
        .then { |sha256| Digest::RMD160.digest(sha256) }
        .then { |ripemd160| ripemd160.unpack('H*') }
        .join
    end

    def sha256(hex)
      [hex].pack('H*')
        .then { |binary| Digest::SHA256.digest(binary) }
        .then { |hash2| hash2.unpack('H*') }
        .first
    end

    def ripemd160(hex)
      [hex].pack('H*')
        .then { |binary| Digest::RMD160.digest(binary) }
        .then { |hash2| hash2.unpack('H*') }
        .first
    end

    def checksum(hex)
      hash256(hex)[0...8]
    end

    def base58_encode(hex)
      hex_to_decimal(hex).then { |decimal| Base58.int_to_base58(decimal, :bitcoin) }
    end

    def base58_decode(hex)
      Base58.base58_to_int(hex, :bitcoin)
        .then { |decimal| decimal_to_hex(decimal) }
    end

    def bech32_encode(hex)
      data = hex.unpack('C*')
      hrp = Wallet.chain_params.bech32_hrp
      Bech32.encode(hrp, data, Bech32::Encoding::BECH32)
    end

    def bech32_decode(hex)
      Bech32.decode(hex)
    end

    # Endian
    def big_endian(decimal:, bytes:)
      decimal_to_hex(decimal).rjust(bytes * 2, '0')
    end

    def little_endian(decimal:, bytes:)
      big_endian(decimal:, bytes:).scan(/../).reverse.join
    end

    # Compact size
    def compact_size(decimal)
      if decimal <= 252
        [decimal].pack('C').unpack1('H*')
      elsif decimal > 252 && decimal <= 65535
        'fd' + [decimal].pack('S<').unpack1('H*')
      elsif i > 65535 && i <= 4294967295
        'fe' + [decimal].pack('L<').unpack1('H*')
      elsif i > 4294967295 && i <= 18446744073709551615
        'ff' + [decimal].pack('Q<').unpack1('H*')
      end
    end

    def ecdsa_signature(private_key:, digest:, nonce: nil)
      group = ECDSA::Group::Secp256k1

      signature = nil
      while signature.nil?
        temporary_key = nonce || SecureRandom.random_number(group.order - 1)
        signature = ECDSA.sign(group, private_key, digest, temporary_key)
      end
      signature
    end

    def verify_ecdsa_signature(public_key:, digest:, signature:)
      ECDSA.valid_signature?(public_key, digest, signature)
    end

    def signature_to_der_string(signature)
      ECDSA::Format::SignatureDerString.encode(signature)
    end

    def der_string_to_signature(der_string)
      ECDSA::Format::SignatureDerString.decode(der_string)
    end

    def address_to_scriptpubkey(address)
      is_bench32 = address.start_with?(Wallet.chain_params.bech32_hrp)

      if is_bench32
        Bech32::SegwitAddr.new(address).to_script_pubkey
      else
        base58_decode(address)
          .chars[2..41]
          .join
          .then { |public_key_hash| Wallet::Script::PayToPublicKeyHash.new(public_key_hash:) }
          .scriptpubkey
      end
    end
  end
end
