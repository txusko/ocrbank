require './lib/ocr.rb'
ocr = OCR::OCR.new
while (temp_num = ocr.scan_number)
  account = ocr.get_account(temp_num)
  number = ocr.check_number(temp_num)
  if account
    puts account
  else
    puts number
  end
end
