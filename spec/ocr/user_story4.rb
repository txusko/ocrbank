require 'spec_helper'

module OCR
  describe 'User story 4' do
    before do
      init_helper('./data/user_story4')
    end
    it 'check length data' do
      check_length
    end
    it 'check filename' do
      @expected.each_with_index do |expected_account, index|
        account = @ocr.get_account(@results[index])
        expect(account).to eq(expected_account)
        # puts
        # puts "num:#{@results[index]}"
        # puts "acc:#{account}"
        # puts "exp:#{expected_account}"
      end
    end
    it 'check account 200000000' do
      expect(@ocr.get_account('200000000')).to eq('200800000')
    end
  end
end
