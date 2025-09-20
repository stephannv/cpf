require "./spec_helper"

describe CPF do
  describe "#value" do
    it "returns value" do
      cpf = CPF.new("466.828.070-40")
      cpf.value.should eq "466.828.070-40"

      cpf = CPF.new("46682807040")
      cpf.value.should eq "46682807040"
    end
  end

  describe "#initialize" do
    INVALID_VALUES.each do |value|
      context "with invalid value: #{value}" do
        it "raises CPF::InvalidValueError" do
          expect_raises(CPF::InvalidValueError, "Invalid CPF value") do
            CPF.new(value)
          end
        end
      end
    end

    VALID_VALUES.each do |value|
      context "with valid value: #{value}" do
        it "returns a CPF object" do
          cpf = CPF.new(value)
          cpf.class.should eq CPF
        end
      end
    end
  end

  describe ".parse" do
    INVALID_VALUES.each do |value|
      context "with invalid value: #{value}" do
        it "returns nil" do
          expect_raises(CPF::InvalidValueError, "Invalid CPF value") do
            cpf = CPF.new(value)
            cpf.should be_nil
          end
        end
      end
    end

    VALID_VALUES.each do |value|
      context "with valid value: #{value}" do
        it "returns a CPF object" do
          cpf = CPF.new(value)
          cpf.class.should eq CPF
        end
      end
    end
  end

  describe "#formatted" do
    it "returns formatted CPF" do
      cpf = CPF.new("592.736.970-70")
      cpf.formatted.should eq "592.736.970-70"

      cpf = CPF.new("23158274000")
      cpf.formatted.should eq "231.582.740-00"
    end
  end

  describe "#unformatted" do
    it "returns formatted CPF" do
      cpf = CPF.new("592.736.970-70")
      cpf.unformatted.should eq "59273697070"

      cpf = CPF.new("23158274000")
      cpf.unformatted.should eq "23158274000"
    end
  end
end

private INVALID_VALUES = [
  "",
  "abc",
  "123",
  "abc.def.ghi-jh",
  "123.456.789-01",
  "466,828.070-40",
  "466,828..070_40",
  " 466.828.070-40 ",
  "466 828 070 40",
  "11111111111",
  "111.111.111-11",
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

private VALID_VALUES = [
  "466.828.070-40",
  "46682807040",
  "820.711.770-29",
  "82071177029",
  "945.592.260-67",
  "94559226067",
  "592.736.970-70",
  "23158274000",
  "164.818.810-99",
  "57958409044",
  "922.370.430-86",
]
