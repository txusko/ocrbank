require 'ocr'

def init_helper(filename)
  @ocr = OCR::OCR.new
  # expected
  @expected = File.open(filename + '_out.txt').each_line.map(&:chomp)
  # read
  @results = @ocr.scan_file(filename + '_in.txt')
end

def check_length
  expect(@expected.length).to be > 0
  expect(@results.length).to be > 0
  expect(@results.length).to eq(@expected.length)
end
