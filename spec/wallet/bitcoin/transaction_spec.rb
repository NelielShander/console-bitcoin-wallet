require_relative '../../spec_helper'

RSpec.describe Wallet::Bitcoin::Transaction do
  include SpecHelper
  subject { described_class }

  it '#new' do
    expect(subject).to respond_to(:new)
    expect(subject.new).to be_an_instance_of(described_class)
  end

  describe '#instance of Transaction' do
    subject { described_class.new }

    it '.raw_data' do
      expect(subject).to respond_to(:raw_data)
    end

    it '.fields' do
      expect(subject).to respond_to(:fields)
      expect(subject.fields).to eq({version: '01000000', inputcount: '00', inputs: [], outputcount: '00', outputs: [], locktime: '00000000'})
    end

    it '.version' do
      expect(subject).to respond_to(:version)
      expect(subject.version).to eq('01000000')
    end

    it '.inputcount' do
      expect(subject).to respond_to(:inputcount)
      expect(subject.inputcount).to eq('00')
    end

    it '.outputcount' do
      expect(subject).to respond_to(:outputcount)
      expect(subject.outputcount).to eq('00')
    end

    it '.locktime' do
      expect(subject).to respond_to(:locktime)
      expect(subject.locktime).to eq('00000000')
    end
  end
end
