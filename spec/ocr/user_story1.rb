require 'spec_helper'

module OCR
  describe "'when user story 1'" do
    before do
      @ocr = OCR.new
      # expected
      @expected = File.open('./data/user_story1_out.txt').each_line.map(&:chomp)
      # read
      @results = @ocr.scan_file('./data/user_story1_in.txt')
    end
    it 'check length data' do
      expect(@expected.length).to be > 0
      expect(@results.length).to be > 0
      expect(@results.length).to eq(@expected.length)
    end
    it 'check filename' do
      @expected.each_with_index do |expected_number, index|
        expect(@results[index]).to eq(expected_number)
      end
    end
    it 'check number 0' do
      number_test = ' _ ' \
                    '| |' \
                    '|_|'
      expect(@ocr.get_number([number_test]).to_i).to eq(0)
    end
    it 'check number 1' do
      number_test = '   ' \
                    '  |' \
                    '  |'
      expect(@ocr.get_number([number_test]).to_i).to eq(1)
    end
    it 'check number 2' do
      number_test = ' _ ' \
                    ' _|' \
                    '|_ '
      expect(@ocr.get_number([number_test]).to_i).to eq(2)
    end
    it 'check number 3' do
      number_test = ' _ ' \
                    ' _|' \
                    ' _|'
      expect(@ocr.get_number([number_test]).to_i).to eq(3)
    end
    it 'check number 4' do
      number_test = '   ' \
                    '|_|' \
                    '  |'
      expect(@ocr.get_number([number_test]).to_i).to eq(4)
    end
    it 'check number 5' do
      number_test = ' _ ' \
                    '|_ ' \
                    ' _|'
      expect(@ocr.get_number([number_test]).to_i).to eq(5)
    end
    it 'check number 6' do
      number_test = ' _ ' \
                    '|_ ' \
                    '|_|'
      expect(@ocr.get_number([number_test]).to_i).to eq(6)
    end
    it 'check number 7' do
      number_test = ' _ ' \
                    '  |' \
                    '  |'
      expect(@ocr.get_number([number_test]).to_i).to eq(7)
    end
    it 'check number 8' do
      number_test = ' _ ' \
                    '|_|' \
                    '|_|'
      expect(@ocr.get_number([number_test]).to_i).to eq(8)
    end
    it 'check number 9' do
      number_test = ' _ ' \
                    '|_|' \
                    ' _|'
      expect(@ocr.get_number([number_test]).to_i).to eq(9)
    end
    it 'check number 123456789' do
      number_test = Array.new(3)
      number_test[0] = '    _  _     _  _  _  _  _ '
      number_test[1] = '  | _| _||_||_ |_   ||_||_|'
      number_test[2] = '  ||_  _|  | _||_|  ||_| _|'
      expect(@ocr.recover_number(number_test)).to eq('123456789')
    end
    it 'check number 000000001' do
      number_test = Array.new(3)
      number_test[0] = ' _  _  _  _  _  _  _  _    '
      number_test[1] = '| || || || || || || || |  |'
      number_test[2] = '|_||_||_||_||_||_||_||_|  |'
      expect(@ocr.recover_number(number_test).to_i).to eq(1)
    end
  end
end
