require 'dry/configurable'
module Wallet
  extend self
  extend Dry::Configurable
  extend Utils

  setting :network, default: 'signet'

  def details
    $stdout.puts "private key: #{private_key.hex}"
    $stdout.puts "public key: #{public_key.hex}"
    $stdout.puts "address: #{address}"
    $stdout.puts "balance: #{balance(utxos)} #{unit}"
  end

  def send_amount(pay_to:, amount:, fee: 1000)
    validate_address(pay_to)
    check_balance(amount:, fee:)

    tx = Bitcoin.new_transaction
      .then { |tx| Bitcoin.add_inputs(tx:, amount:, fee:, utxos:) }
      .then { |tx| Bitcoin.add_outputs(tx:, amount:, fee:, pay_to:) }
      .then { |tx| Bitcoin.sign_transaction(tx:, pay_to:) }

    tx.details
    Wallet::Mempool.post_transaction(tx.raw_data)
  end

  def private_key
    if Storage.has_key?
      hex = Storage.get_key
      Key::PrivateKey.new(hex:)
    else
      new_private_key = Key::PrivateKey.new
      Storage.put_key(new_private_key.hex)
      new_private_key
    end
  end

  def public_key
    Key::PublicKey.new(private_key:)
  end

  def address
    hash160(public_key.hex)
      .then { |public_key_hash| Key::Address.new(public_key_hash).hex }
  end

  def utxos
    Mempool.get_address_utxo(address)
      .sort_by { |utxo| utxo['status']['block_time'] }
  end

  def unit
    (config.network == 'mainnet') ? 'Sats' : 'sSats'
  end

  def validate_address(pay_to)
    validation = Mempool.get_address_validation(pay_to)
    raise validation['error'] if validation['isvalid'] == false
  end

  def check_balance(amount:, fee:)
    current_balance = balance(utxos)
    raise "Not enough funds. Balance is #{current_balance} uBTC." if current_balance <= amount + fee
  end

  def balance(utxos = [])
    utxos.inject(0) do |sum, utxo|
      sum + utxo['value'] if utxo['status']['confirmed']
    end
  end

  def chain_params
    ChainParams.init
  end
end
