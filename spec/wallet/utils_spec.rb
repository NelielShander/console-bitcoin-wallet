require_relative '../spec_helper'

RSpec.describe Wallet::Utils do
  include SpecHelper

  let(:subject) { Class.new { extend Wallet::Utils } }

  it '.hex_to_decimal' do
    expect(subject.hex_to_decimal('02A13B')).to eql(172347)
  end

  it '.decimal_to_hex' do
    expect(subject.decimal_to_hex(6735)).to eql('1a4f')
  end

  it '.bytesize' do
    expect(subject.bytesize('61dc9ff8b15450212970c6fa997338bb205dd48ffaca3a056b09a3b44a244d76')).to eql(32)
  end

  it '.hash256' do
    expect(subject.hash256('020000003e551ce760f1ca511e7e75430ab35cca34a9e20b01542a9f0100000000000000384ae1af253a280c09d7f947f83b034e7962b3b8374843b0b4161dd8299111d13302725285fc0a191635b26d'))
      .to eql('11c59bd0cf2ae840a671d910d4275393ee9bf8140cf96e800200000000000000')
  end

  it '.hash160' do
    expect(subject.hash160('0211190d24b6443c5f380a0a83fa0cdb4ae51be43e646292ac98802a91a7e66bab'))
      .to eql('1de772095f63f5df2c4e690e3747b24a430f3bad')
  end

  it '.sha256' do
    expect(subject.sha256('9918db83909bb90ca1da40c786c280'))
      .to eql('194eda01735e13d0ed9931c0b94a382ad279ac1087eb1498632c5bf2cceb1038')
  end

  it '.ripemd160' do
    expect(subject.ripemd160('9918db83909bb90ca1da40c786c280')).to eql('110f8bd02c32ea2821d35f1345dc83aaeb351dbd')
  end

  it '.checksum' do
    expect(subject.checksum('d9d76f335e9e5f3279e5c5b88b2e8ba508924e1e')).to eql('eefe4bb6')
  end

  it '.base58_encode' do
    expect(subject.base58_encode('6f558df0c6f0fbbf80398fcb0d9beb75f8fc0d72cf2641a66c'))
      .to eql('moKKmZVBCCBrjitpS2VWu8kCVkg7Bh6p6f')
  end

  it '.base58_decode' do
    expect(subject.base58_decode('moKKmZVBCCBrjitpS2VWu8kCVkg7Bh6p6f'))
      .to eql('6f558df0c6f0fbbf80398fcb0d9beb75f8fc0d72cf2641a66c')
  end

  it '.big_endian' do
    expect(subject.big_endian(decimal: 10000, bytes: 4)).to eql('00002710')
  end

  it '.little_endian' do
    expect(subject.little_endian(decimal: 10000, bytes: 4)).to eql('10270000')
  end
end
