require 'spec_helper'

module OCR
  describe 'User story 2' do
    before do
      @ocr = OCR.new
    end
    it 'true checksum' do
      expect(@ocr.checksum?('457508000')).to be true
    end
    it 'false checksum' do
      expect(@ocr.checksum?('664371495')).to be false
    end
    it 'other true checksum' do
      expect(@ocr.checksum?('000000000')).to be true
      expect(@ocr.checksum?('100000010')).to be true
      expect(@ocr.checksum?('010000100')).to be true
      expect(@ocr.checksum?('010000011')).to be true
      expect(@ocr.checksum?('001001000')).to be true
      expect(@ocr.checksum?('001000101')).to be true
      expect(@ocr.checksum?('000110000')).to be true
      expect(@ocr.checksum?('000101001')).to be true
      expect(@ocr.checksum?('000100110')).to be true
      expect(@ocr.checksum?('000011010')).to be true
    end
    it 'other false checksum' do
      expect(@ocr.checksum?('000000001')).to be false
      expect(@ocr.checksum?('000000010')).to be false
      expect(@ocr.checksum?('000000100')).to be false
      expect(@ocr.checksum?('000001000')).to be false
      expect(@ocr.checksum?('000010000')).to be false
      expect(@ocr.checksum?('000100000')).to be false
      expect(@ocr.checksum?('001000000')).to be false
      expect(@ocr.checksum?('010000000')).to be false
      expect(@ocr.checksum?('100000000')).to be false
    end
  end
end
