require './ruby_basics/9_debugging/spec/spec_helper'
require_relative './caesar_cipher'

RSpec.describe 'Caesar Cipher' do
  describe '#caesar_cipher' do
    it 'returns the ciphered message with positive shift' do
      expect(caesar_cipher('Hello, World!', 3)).to eq('Khoor, Zruog!')
    end

    it 'returns the ciphered message with negative shift' do
      expect(caesar_cipher('Hello, World!', -3)).to eq('Ebiil, Tloia!')
    end

    it 'returns the ciphered message with shift greater than 26' do
      expect(caesar_cipher('Hello, World!', 30)).to eq('Lipps, Asvph!')
    end

    it 'returns the ciphered message with shift less than -26' do
      expect(caesar_cipher('Hello, World!', -30)).to eq('Fcjjm, Umpjb!')
    end

    it 'returns the ciphered message with no shift' do
      expect(caesar_cipher('Hello, World!', 0)).to eq('Hello, World!')
    end

    it 'returns the ciphered message with empty string' do
      expect(caesar_cipher('', 5)).to eq('')
    end

    it 'returns the ciphered message with special characters' do
      expect(caesar_cipher('!@#$%^&*()', 10)).to eq('!@#$%^&*()')
    end
  end
end
