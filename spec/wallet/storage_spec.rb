require_relative '../spec_helper'

RSpec.describe Wallet::Storage do
  include SpecHelper
  subject { described_class }

  it '#get_key' do
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:read).and_return('private_key')

    expect(subject.get_key).to eq('private_key')
  end

  it '#put_key' do
    allow(File).to receive(:write).and_return(true)

    expect(subject.put_key('private_key')).to eq('private_key')
  end

  it '#has_key?' do
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:read).and_return('private_key')

    expect(subject.has_key?).to be_truthy
  end
end
