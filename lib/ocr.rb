CHAR_LEN = 3
NUM_LEN = 9
NUMBERS = [
  ' _ ' \
  '| |' \
  '|_|',
  '   ' \
  '  |' \
  '  |',
  ' _ ' \
  ' _|' \
  '|_ ',
  ' _ ' \
  ' _|' \
  ' _|',
  '   ' \
  '|_|' \
  '  |',
  ' _ ' \
  '|_ ' \
  ' _|',
  ' _ ' \
  '|_ ' \
  '|_|',
  ' _ ' \
  '  |' \
  '  |',
  ' _ ' \
  '|_|' \
  '|_|',
  ' _ ' \
  '|_|' \
  ' _|'
].freeze

module OCR
  # OCR Reader class
  class OCR
    def scan_number
      lines = [read_line(gets), read_line(gets), read_line(gets)]
      return nil unless lines[0] && lines[1] && lines[2]
      gets # 4rth line (enter)
      recover_number(lines)
    end

    def scan_file(filename)
      results = []
      lines = []
      File.open(filename).each_line do |line|
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
      hash = NUMBERS.map.with_index.to_a.to_h
      numbers.map { |i| hash[i] ? hash[i].to_s : '?' }.join
    end

    def checksum?(number)
      tot = 0
      processed_number = number.to_s.rjust(NUM_LEN, '0').reverse
      processed_number.chars.each_with_index do |element, i|
        tot += (i + 1) * element.to_i
      end

      # Why 11 (maybe include a constant that explains what this 11 is)?
      (tot % 11).zero?
    end

    def get_account(number)
      alts = []
      number = get_account_with_question_marks(number)
      if !checksum?(number)
        define_equivalences.each_with_index do |num, index|
          next if num.nil?
          num.each do |elem|
            next unless number.include?(index.to_s)
            get_num_alternatives(number, index,
                                 elem.to_s, alts)
          end
        end
      else
        alts.push(number) unless alts.include?(number)
      end

      show_alternatives(number, alts)
    end

    def define_equivalences
      [
        [8], [7], nil, [9], nil, [9, 6], [8, 5], [1], [9, 6, 0], [8, 5, 3]
      ]
    end

    def show_alternatives(number, alts)
      if alts.length > 1
        "#{number} AMB ['" + alts.sort.join("', '") + "']"
      else
        check_number(alts[0])
      end
    end

    def get_num_alternatives(number, index, elem, alts)
      number.split('').each_with_index do |_elem, real_index|
        next unless number[real_index] == index.to_s

        cp_num = number.dup
        cp_num[real_index] = elem
        alts.push(cp_num) if !alts.include?(cp_num) && checksum?(cp_num)
      end
    end

    def get_account_with_question_marks(number)
      if number =~ /[?]/
        (0..NUM_LEN).each do |i|
          # check difference between method & method!
          addressed_number = number.sub('?', i.to_s)
          return addressed_number if checksum?(addressed_number)
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
