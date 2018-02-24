require './lib/ocr.rb'
ocr = OCR::OCR.new
while (temp_num = ocr.scan_number)
  puts ocr.check_number(temp_num)
end
