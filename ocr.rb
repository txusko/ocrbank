CHAR_LEN = 3
NUM_LEN = 9
NUMBERS = []
NUMBERS[0]  = " _ " +
              "| |" +
              "|_|"
NUMBERS[1]  = "   " +
              "  |" +
              "  |"
NUMBERS[2]  = " _ " +
              " _|" +
              "|_ "
NUMBERS[3]  = " _ " +
              " _|" +
              " _|"
NUMBERS[4]  = "   " +
              "|_|" +
              "  |"
NUMBERS[5]  = " _ " +
              "|_ " +
              " _|"
NUMBERS[6]  = " _ " +
              "|_ " +
              "|_|"
NUMBERS[7]  = " _ " +
              "  |" +
              "  |"
NUMBERS[8]  = " _ " +
              "|_|" +
              "|_|"
NUMBERS[9]  = " _ " +
              "|_|" +
              " _|"


def read_line
    line = gets
    line ? line[0...(CHAR_LEN * NUM_LEN)] : nil
end

def scan_number
    line1 = read_line
    line2 = read_line
    line3 = read_line
    return nill unless line1 && line2 && line3

    lines = [line1, line2, line3]
    gets #4rth line (enter)
    recover_number(lines)
end

def recover_number(lines)
    part1 = lines[0].scan(/.../)
    part2 = lines[1].scan(/.../)
    part3 = lines[2].scan(/.../)
    numbers = part1.zip(part2, part3).map { |part| part.join }
    get_number(numbers)
end

def get_number(numbers)
    hash = Hash[NUMBERS.map.with_index.to_a]
    numbers.map{ |i| hash[i] ? hash[i].to_s : "?" }.join
end

def checksum?(number)
    tot = 0;
    number.reverse.chars.each_with_index { |e, index|
      tot += (index + 1) * e.to_i
    }
    (tot % 11) == 0
end

def show_number(number)
    print number
    if number =~ /[?]/
        puts " ILL"
    else
        if checksum?(number)
            puts " NIL"
        end
    end
    puts
end

while temp_num = scan_number
    show_number(temp_num)
end

#show_number(scan_number)
