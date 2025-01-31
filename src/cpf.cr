require "./cpf/validator"

# Represents a CPF (Cadastro de Pessoas Físicas) number.
#
# A `CPF` object is designed to never hold an invalid value, so you can assume
# that a CPF object will always hold a valid value.
# ```
# cpf = CPF.new("640.061.830-97")
# cpf.value       # => "640.061.830-97"
# cpf.formatted   # => "640.061.830-97"
# cpf.unformatted # => "64006183097"
#
# CPF.new("11111111111") # => raises `ArgumentError`
#
# CPF.parse("11111111111")    # => nil
# CPF.parse("640.061.830-97") # => #<CPF:0x104fe0ae0 @value="640.061.830-97">
# ```
class CPF
  VERSION = "1.0.0"

  # Returns the value provived on initialization
  #
  # ```
  # cpf = CPF.new("640.061.830-97")
  # cpf.value # => "640.061.830-97"
  # ```
  getter value : String

  # Creates a `CPF` from a `String`.
  #
  # It accepts formatted and stripped strings
  #
  # If the String isn't a valid CPF, an `ArgumentError` exception will be
  # raised. See `.parse` if you want a safe way to initialize a CPF.
  def self.new(value : String) : CPF
    new(value, validate: true)
  end

  # Returns a `CPF` if the given String is a valid CPF number, otherwise
  # returns `nil`.
  def self.parse(value : String) : CPF?
    return unless CPF::Validator.valid?(value)

    new(value, validate: false)
  end

  private def initialize(@value : String, validate : Bool)
    return unless validate

    unless CPF::Validator.valid?(value)
      raise ArgumentError.new("Invalid CPF format")
    end
  end

  # Returns the formatted CPF number
  #
  # ```
  # cpf = CPF.new("64006183097")
  # cpf.formatted # => "640.061.830-97"
  # ```
  def formatted : String
    value.gsub(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, "\\1.\\2.\\3-\\4")
  end

  # Returns the unformatted CPF number
  #
  # ```
  # cpf = CPF.new("640.061.830-97")
  # cpf.unformatted # => "64006183097"
  # ```
  def unformatted : String
    value.gsub(/[^\d]/, "")
  end
end
