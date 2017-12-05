input = []
File.open('inputs/day4.txt') {|f|
  f.each_line {|line|
    input.push line
  }
}

valid_passphrases = 0

input.each {|passphrase|
  valid_passphrase = true

  phrase_words = []
  passphrase.split(' ').each {|word|
    if phrase_words.include? word
      valid_passphrase = false
      break

    end

    phrase_words.push(word)
  }

  valid_passphrases += 1 if valid_passphrase
}

puts valid_passphrases