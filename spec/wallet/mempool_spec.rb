require_relative '../spec_helper'

RSpec.describe Wallet::Mempool do
  include SpecHelper
  subject { described_class }

  it '#get_address_validation' do
    expect(subject).to respond_to(:get_address_validation)
  end

  it '#get_address_transactions' do
    expect(subject).to respond_to(:get_address_transactions)
  end

  it '#get_address_utxo' do
    expect(subject).to respond_to(:get_address_utxo)
  end

  it '#post_transaction' do
    expect(subject).to respond_to(:post_transaction)
  end

  it '#client' do
    expect(subject).to respond_to(:client)
  end

  it '#network' do
    expect(subject).to respond_to(:network)
  end
end
