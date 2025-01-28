# CPF

CPF number validation and formatting for Crystal.

CPF (Cadastro de Pessoa Físical) is the Brazilian individual taxpayer registry.
It's an 11-digit number in the format 000.000.000-00, where the last 2 numbers
are check digits, generated through an arithmetic operation on the first nine
digits.

[API Reference](https://crystaldoc.info/github/stephannv/cpf)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cpf:
       github: stephannv/cpf
   ```

2. Run `shards install`

## Usage

[API Reference](https://crystaldoc.info/github/stephannv/cpf)

```crystal
require "cpf"

# With valid formatted value
cpf = CPF.new("640.061.830-97")
cpf.value # => "640.061.830-97"
cpf.formatted # => "640.061.830-97"
cpf.unformatted # => "64006183097"

# With valid unformatted value
cpf = CPF.new("64006183097")
cpf.value # => "64006183097"
cpf.formatted # => "640.061.830-97"
cpf.unformatted # => "64006183097"
```

A `CPF` object is designed to never hold an invalid value, so you can assume
that a CPF object will always hold a valid value. If you try to initialize a
CPF object with an invalid value, it will raise an exception:

```crystal
CPF.new("11111111111") # => raises `ArgumentError`

CPF.new("111.111.111-11") # => raises `ArgumentError`
```

To safely initialize a CPF object, use the `.parse` method:
```crystal
# With invalid value
CPF.parse("11111111111") # => nil

# With valid value
CPF.parse("640.061.830-97") # => #<CPF:0x104fe0ae0 @value="640.061.830-97">
```

You can use `CPF::Validator` module to validate a CPF number:
```crystal
CPF::Validator.valid?("11111111111") # => false

CPF::Validator.valid?("640.061.830-97") # => true
```

## Development

1. `shards install` to install dependencies
2. `crystal spec` to run tests

## Contributing

1. Fork it (<https://github.com/stephannv/cpf/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [stephann](https://github.com/stephannv) - creator and maintainer
