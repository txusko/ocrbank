CHAR_LEN = 3
NUM_LEN = 9
NUMBERS = Array.new(10)
NUMBERS[0]  = ' _ ' \
              '| |' \
              '|_|'
NUMBERS[1]  = '   ' \
              '  |' \
              '  |'
NUMBERS[2]  = ' _ ' \
              ' _|' \
              '|_ '
NUMBERS[3]  = ' _ ' \
              ' _|' \
              ' _|'
NUMBERS[4]  = '   ' \
              '|_|' \
              '  |'
NUMBERS[5]  = ' _ ' \
              '|_ ' \
              ' _|'
NUMBERS[6]  = ' _ ' \
              '|_ ' \
              '|_|'
NUMBERS[7]  = ' _ ' \
              '  |' \
              '  |'
NUMBERS[8]  = ' _ ' \
              '|_|' \
              '|_|'
NUMBERS[9]  = ' _ ' \
              '|_|' \
              ' _|'

module OCR
  # OCR Reader class
  class OCR
    def scan_number
      lines = [read_line(gets), read_line(gets), read_line(gets)]
      return nill unless lines[0] && lines[1] && lines[2]
      gets # 4rth line (enter)
      recover_number(lines)
    end

    def scan_file(filename)
      results = []
      lines = []
      File.open(filename).each do |line|
        lines.push(line)
        next unless lines.length >= 4
        results.push(recover_number(lines))
        lines = []
      end
      results
    end

    def read_line(line)
      line ? line[0...(CHAR_LEN * NUM_LEN)].ljust(CHAR_LEN * NUM_LEN) : nil
    end

    def recover_number(lines)
      part1 = lines[0].scan(/.../)
      part2 = lines[1].scan(/.../)
      part3 = lines[2].scan(/.../)
      numbers = part1.zip(part2, part3).map(&:join)
      get_number(numbers)
    end

    def get_number(numbers)
      hash = Hash[NUMBERS.map.with_index.to_a]
      numbers.map { |i| hash[i] ? hash[i].to_s : '?' }.join
    end

    def checksum?(number)
      tot = 0
      number = number.to_s.rjust(9, '0')
      number.reverse.chars.each_with_index do |e, index|
        tot += (index + 1) * e.to_i
      end
      (tot % 11).zero?
    end

    def get_account(number)
      alts = []
      number = get_account_with_question_marks(number)
      if !checksum?(number)
        equivalences = []
        equivalences[0] = [8]
        equivalences[1] = [7]
        equivalences[3] = [9]
        equivalences[5] = [9, 6]
        equivalences[6] = [8, 5]
        equivalences[7] = [1]
        equivalences[9] = [8, 5, 3]
        equivalences[8] = [9, 6, 0]
        equivalences.each_with_index do |num, index|
          next if num.nil?
          num.each do |to_num|
            cp_num = number.dup
            next unless number.include?(index.to_s)
            get_num_alternatives(number, index, cp_num,
                                 to_num.to_s, alts)
          end
        end
      else
        alts.push(number) unless alts.include?(number)
      end
      show_alternatives(number, alts)
    end

    def show_alternatives(number, alts)
      alts.sort!
      if alts.length > 1
        "#{number} AMB ['" + alts.join("', '") + "']"
      else
        alts[0]
      end
    end

    def get_num_alternatives(number, index, cp_num, to_num, alts)
      realindex = 0
      cp_num.split('').each do
        cp_num = number.dup
        if cp_num[realindex] == index.to_s
          cp_num[realindex] = to_num
          alts.push(cp_num) if !alts.include?(cp_num) && checksum?(cp_num)
        end
        realindex += 1
      end
    end

    def get_account_with_question_marks(number)
      if number =~ /[?]/
        (0..9).each do |i|
          cp_number = number.dup
          cp_number = cp_number.sub('?', i.to_s)
          return cp_number if checksum?(cp_number)
        end
      end
      number
    end

    def check_number(number)
      if number =~ /[?]/
        "#{number} ILL"
      elsif !checksum?(number)
        "#{number} ERR"
      else
        number.to_s
      end
    end
  end
end
