# frozen_string_literal: true

module Wallet
  module Mempool
    module_function

    HOST = 'https://mempool.space'

    def get_address_validation(address)
      uri = "#{HOST}/#{network}/api/v1/validate-address/#{address}"

      client.get(uri)
    end

    def get_address_transactions(address)
      uri = "#{HOST}/#{network}/api/address/#{address}/txs"

      client.get(uri)
    end

    def get_address_utxo(address)
      uri = "#{HOST}/#{network}/api/address/#{address}/utxo"

      client.get(uri)
    end

    def get_transaction(txid)
      uri = "#{HOST}/#{network}/api/tx/#{txid}"

      client.get(uri)
    end

    def get_transaction_hex(txid)
      uri = "#{HOST}/#{network}/api/tx/#{txid}/hex"

      client.get(uri, parse: false)
    end

    def post_transaction(payload)
      uri = "#{HOST}/#{network}/api/tx"

      client.post(uri, payload)
    end

    def client
      Client.new
    end

    def network
      Wallet.chain_params.network
    end
  end
end
