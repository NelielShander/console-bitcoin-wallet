require_relative '../spec_helper'

RSpec.describe Wallet::ChainParams do
  include SpecHelper
  subject { described_class }

  it '#init' do
    expect(subject).to respond_to(:init)
    expect(subject.init).to be_an_instance_of(described_class)
  end

  describe 'instance of ChainParams' do
    subject { described_class.init }

    it 'respond to methods' do
      expect(subject).to respond_to(:network)
      expect(subject).to respond_to(:magic_head)
      expect(subject).to respond_to(:address_version)
      expect(subject).to respond_to(:p2sh_version)
      expect(subject).to respond_to(:bech32_hrp)
      expect(subject).to respond_to(:privkey_version)
      expect(subject).to respond_to(:extended_privkey_version)
      expect(subject).to respond_to(:extended_pubkey_version)
      expect(subject).to respond_to(:default_port)
      expect(subject).to respond_to(:dns_seeds)
    end
  end
end
