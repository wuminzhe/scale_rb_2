# frozen_string_literal: true

require 'scale_rb_2'
require 'json'

RSpec.describe PortableTypes do
  before(:all) do
    types = JSON.parse(File.open('./substrate-types.json').read)
    @registry = types.map { |type| [type['id'], type['type']] }.to_h

    kusama_types = JSON.parse(File.open('./substrate-types.json').read)
    @kusama_registry = kusama_types.map { |type| [type['id'], type['type']] }.to_h
  end

  it 'can decode fixed uint' do
    value, remaining_bytes = PortableTypes.decode 2, [0x45], @registry
    expect(value).to eql(69)
    expect(remaining_bytes).to eql([])
  end

  it 'can decode array' do
    value, remaining_bytes = PortableTypes.decode 1, [0x12, 0x34, 0x56, 0x78] * 8 + [0x78], @registry
    expect(value).to eql([0x12, 0x34, 0x56, 0x78] * 8)
    expect(remaining_bytes).to eql([0x78])
  end

  it 'can decode sequence' do
    value, remaining_bytes = PortableTypes.decode 11, '0x0c003afe'.to_bytes, @registry
    expect(value).to eql([0, 58, 254])
    expect(remaining_bytes).to eql([])
  end

  it 'can decode composite1' do
    # AccountId32
    value, remaining_bytes = PortableTypes.decode 0, [0x12, 0x34, 0x56, 0x78] * 8, @registry
    expect(value).to eql([
                           [0x12, 0x34, 0x56, 0x78] * 8
                         ])
    expect(remaining_bytes).to eql([])
  end

  it 'can decode composite2' do
    # has name
    bytes = [0x00, 0xe4, 0x0b, 0x54, 0x03, 0x00, 0x00, 0x00]
    value, = PortableTypes.decode 8, bytes, @registry
    expect(value).to eql([
                           ['ref_time', 14_294_967_296]
                         ])

    # empty fields
    value, = PortableTypes.decode 161, [], @registry
    expect(value).to eql([])
  end

  it 'can decode composite3' do
    bytes = '0x05000000000000000100000000000000142ba3d4e80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'.to_bytes

    value, = PortableTypes.decode 3, bytes, @registry
    expect(value).to eql([
                           ['nonce', 5],
                           ['consumers', 0],
                           ['providers', 1],
                           ['sufficients', 0],
                           ['data', [
                             ['free', 999_999_875_860],
                             ['reserved', 0],
                             ['misc_frozen', 0],
                             ['fee_frozen', 0]
                           ]]
                         ])
  end

  it 'can decode composite4' do
    bytes = '0x020406010700f2052a017d01260000400d03000000000000000000000000000000000000000000000000000000000001004617d470f847ce166019d19a7944049ebb01740000000000000000000000000000000000000000000000000000000000000000001019ff1d2100'.to_bytes
    value, remaining_bytes = PortableTypes.decode 542, bytes, @kusama_registry
    p value
  end
  
  it 'can decode tuple' do
    bytes = [0x12, 0x34, 0x56, 0x78] * 8 + '0x0bfeffffffffffff0000000000000000'.to_bytes
    # tuple: [0, 6]
    value, remaining_bytes = PortableTypes.decode 55, bytes, @registry
    expect(value).to eql([
                           [
                             [0x12, 0x34, 0x56, 0x78] * 8
                           ], # composite
                           18_446_744_073_709_551_115 # u128
                         ])
    expect(remaining_bytes).to eql([])
  end

  it 'can decode variant' do
    value, remaining_bytes = PortableTypes.decode 87, [0x01, 0x02], @registry
    expect(value).to eql('NonTransfer')
    expect(remaining_bytes).to eql([0x02])
  end
end
