require_relative '../../spec_helper'

RSpec.describe Wallet::Key::Address do
  include SpecHelper

  let(:hash160) { 'c2c7fe92fa44ae7cef1c9efa4921db48dcdcb181' }
  let(:address) { 'myGry8FFiy3UiD9dSCkDgU3Hjr4n73YQ51' }

  subject { described_class }

  it '#new' do
    expect(subject).to respond_to(:new)
  end

  describe 'instance of Wallet::Key::Address' do
    subject { described_class.new(hash160) }

    it '.hex' do
      expect(subject).to respond_to(:hex)
      expect(subject.hex).to be_a(String)
      expect(subject.hex).to eql(address)
    end
  end
end
