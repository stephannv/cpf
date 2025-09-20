struct CPF
  # Provides CPF number validation method
  module Validator
    extend self

    private REGEX = %r{^\d{3}\.?\d{3}\.?\d{3}-?\d{2}$}

    private BLOCK_LIST = [
      "11111111111",
      "22222222222",
      "33333333333",
      "44444444444",
      "55555555555",
      "66666666666",
      "77777777777",
      "88888888888",
      "99999999999",
      "00000000000",
      "12345678909",
    ]

    # Returns `true` if the given value is a valid CPF number, otherwise
    # returns false
    #
    # ```
    # CPF::Validator.valid?("11111111111") # => false
    # CPF::Validator.valid?("64006183097") # => true
    # ```
    def valid?(value : String) : Bool
      return false unless valid_format?(value)
      return false if blocked?(value)

      numbers : Array(UInt8) = value.chars.select(&.number?).map(&.to_u8)

      valid_digit?(digit: numbers[9], numbers: numbers[0, 9]) &&
        valid_digit?(digit: numbers[10], numbers: numbers[0, 10])
    end

    private def valid_format?(value : String) : Bool
      value.matches? REGEX
    end

    private def blocked?(value : String) : Bool
      BLOCK_LIST.includes?(value.gsub(/\D/, ""))
    end

    private def valid_digit?(digit : UInt8, numbers : Array(UInt8)) : Bool
      total = 0
      size = numbers.size

      numbers.each_with_index do |number, index|
        total += number * ((size + 1) - index)
      end

      rest = total % 11

      if rest == 0 || rest == 1
        return false if digit != 0
      else
        return false if digit != (11 - rest)
      end

      true
    end
  end
end
