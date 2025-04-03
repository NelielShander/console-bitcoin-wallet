module Wallet
  module Bitcoin
    extend self
    extend Wallet::Utils

    SIGNATURE_HASH_TYPES = {
      sighash_all: '0x01',
      sighash_none: '0x02',
      sighash_single: '0x03',
      sighash_anyonecanpay_sighash_all: '0x81',
      sighash_anyonecanpay_sighash_none: '0x82',
      sighash_anyonecanpay_sighash_single: '0x83'
    }.freeze

    def new_transaction
      Transaction.new
    end

    def add_inputs(tx:, amount:, fee:, utxos:)
      inputs_amount = 0 - fee

      utxos.each do |utxo|
        break if inputs_amount > amount

        inputs_amount += utxo['value']
        tx.inputs << Input.new(utxo:)
      end
      tx
    end

    def add_outputs(tx:, amount:, fee:, pay_to:)
      scriptpubkey = address_to_scriptpubkey(pay_to)
      payment = Output.new(amount:, scriptpubkey:)
      tx.outputs << payment
      change_amount = tx.inputs_amount - fee - amount

      unless change_amount == 0
        change_scriptpubkey = address_to_scriptpubkey(Wallet.address)
        change = Output.new(amount: change_amount, scriptpubkey: change_scriptpubkey)
        tx.outputs << change
      end
      tx
    end

    def sign_transaction(tx:, pay_to:)
      remove_exiting_script_sigs(tx)
        .then { |unsigned_tx| placehold_scriptsig(tx: unsigned_tx, pay_to:) }
        .then { |placeholded_tx| placeholded_tx.raw_data }
        .then { |tx_data| tx_data_sighash(tx_data) }
        .then { |message| hash256(message) }
        .then { |message_hash| sign_transaction_hash(message_hash) }
        .then { |signature| der_signature(signature) }
        .then { |der_string| der_string + sighash }
        .then { |signature| construct_scriptsig(signature) }
        .then { |scriptsig| insert_scriptsig(tx:, scriptsig:) }
    end

    def insert_scriptsig(tx:, scriptsig:)
      tx.inputs.each { |input| input.scriptsig = scriptsig }
      tx.signed = true
      tx
    end

    def placehold_scriptsig(tx:, pay_to:)
      placeholder = address_to_scriptpubkey(pay_to)
      tx.inputs.each { |input| input.scriptsig = placeholder }
      tx
    end

    def construct_scriptsig(signature)
      public_key = Wallet.public_key.hex
      Wallet::Script::PayToPublicKeyHash.new(public_key:, signature:).scriptsig
    end

    def tx_data_sighash(tx_data)
      tx_data + little_endian(decimal: hex_to_decimal(sighash), bytes: 4)
    end

    def der_signature(signature)
      signature_to_der_string(signature).unpack1('H*')
    end

    def sign_transaction_hash(message)
      private_key = Wallet.private_key.decimal
      digest = [message].pack('H*')

      ecdsa_signature(private_key:, digest:)
    end

    def remove_exiting_script_sigs(transaction)
      transaction.marker = nil
      transaction.flag = nil
      transaction.withess = nil
      transaction
    end

    def sighash(type: :sighash_all)
      SIGNATURE_HASH_TYPES[type][2..]
    end
  end
end
