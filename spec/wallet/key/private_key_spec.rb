require_relative '../../spec_helper'

RSpec.describe Wallet::Key::PrivateKey do
  include SpecHelper
  subject { described_class }

  it '#new' do
    expect(subject).to respond_to(:new)
    expect(subject.new).to be_an_instance_of(described_class)
  end

  describe 'instance of Wallet::Key::PrivateKey' do
    subject { described_class.new }

    it '.hex' do
      expect(subject).to respond_to(:hex)
      expect(subject.hex).to be_a(String)
      expect(subject.hex.bytes.size).to eq(64)
    end
  end
end
