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

def scan_number
  lines = [read_line(gets), read_line(gets), read_line(gets)]
  return nill unless lines[0] && lines[1] && lines[2]
  gets # 4rth line (enter)
  recover_number(lines)
end

def scan_file(filename)
  lines = []
  File.open(filename).each do |line|
    puts line
    lines.push(read_line(line))
    next unless lines.length >= 4
    temp_num = recover_number(lines)
    show_number(temp_num)
    lines = []
  end
end

def read_line(line)
  line ? line[0...(CHAR_LEN * NUM_LEN)].ljust(CHAR_LEN * NUM_LEN) : nil
end

def recover_number(lines)
  part1 = lines[0].scan(/.../)
  part2 = lines[1].scan(/.../)
  part3 = lines[2].scan(/.../)
  numbers = part1.zip(part2, part3).map { |part| part & :join }
  get_number(numbers)
end

def get_number(numbers)
  hash = Hash[NUMBERS.map.with_index.to_a]
  numbers.map { |i| hash[i] ? hash[i].to_s : '?' }.join
end

def checksum?(number)
  tot = 0
  number.reverse.chars.each_with_index do |e, index|
    tot += (index + 1) * e.to_i
  end
  (tot % 11).zero?
end

def show_number(number)
  if number =~ /[?]/
    puts "#{number} ILL"
  elsif !checksum?(number)
    puts "#{number} ERR"
  else
    puts number
  end
end

while (temp_num = scan_number)
  show_number(temp_num)
end

# scan_file('./data/data1.txt')
# scan_file('./data/data2.txt')

# show_number(scan_number)
