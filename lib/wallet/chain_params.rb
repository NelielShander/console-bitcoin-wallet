require 'yaml'

module Wallet
  class ChainParams
    FILE_PATH = "#{__dir__}/chain_params/#{Wallet.config.network}.yml".freeze

    attr_reader :network, :magic_head, :address_version, :p2sh_version, :bech32_hrp, :privkey_version,
      :extended_privkey_version, :extended_pubkey_version, :default_port, :dns_seeds

    def self.init
      YAML.unsafe_load_file(FILE_PATH)
    end
  end
end
