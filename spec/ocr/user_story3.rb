require 'spec_helper'

module OCR
  describe 'User story 3' do
    before do
      @ocr = OCR.new
      # expected
      @expected = File.open('./data/user_story3_out.txt').each_line.map(&:chomp)
      # read
      @results = @ocr.scan_file('./data/user_story3_in.txt')
    end
    it 'check length data' do
      expect(@expected.length).to be > 0
      expect(@results.length).to be > 0
      expect(@results.length).to eq(@expected.length)
    end
    it 'check filename' do
      @expected.each_with_index do |expected_number, index|
        num = @ocr.check_number(@results[index])
        # puts "num:#{@results[index]} res:#{num} exp:#{expected_number}"
        expect(num).to eq(expected_number)
      end
    end
    it 'check correct numbers' do
      expect(@ocr.check_number('000000051')).to eq('000000051')
      expect(@ocr.check_number('457508000')).to eq('457508000')
    end
    it 'check ERR numbers' do
      expect(@ocr.check_number('000000001')).to eq('000000001 ERR')
      expect(@ocr.check_number('664371495')).to eq('664371495 ERR')
    end
    it 'check ILL numbers' do
      expect(@ocr.check_number('86110??36')).to eq('86110??36 ILL')
      expect(@ocr.check_number('49006771?')).to eq('49006771? ILL')
    end
  end
end
