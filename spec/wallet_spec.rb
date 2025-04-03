require_relative 'spec_helper'

RSpec.describe Wallet do
  include SpecHelper
  subject { described_class }

  describe '#config' do
    subject { described_class.config }

    it '.network' do
      expect(subject).to respond_to(:network)
      expect(subject.network).to eql('signet')
    end
  end

  it '#chain_params' do
    expect(subject).to respond_to(:chain_params)
    expect(subject.chain_params).to be_an_instance_of(Wallet::ChainParams)
  end

  it '#details' do
    allow(subject).to receive(:private_key).and_return('private_key')
    allow(subject).to receive(:public_key).and_return('public_key')
    allow(subject).to receive(:address).and_return('address')

    expect(subject).to respond_to(:details)
  end
end
