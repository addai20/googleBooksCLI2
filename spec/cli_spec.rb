# spec/string_calculator_spec.rb
# describe StringCalculator do
#
#   describe ".add" do
#     context "given an empty string" do
#       it "returns zero" do
#         expect(StringCalculator.add("")).to eq(0)
#       end
#     end
#   end
# end
# require 'pry'
require 'cli'
# require 'rails_helper'
# require 'rspec/rails'

# describe Main do
#   describe ".sayGoodbye" do
#     context "When invoked" do
#       it "prints two strings to the console" do
#         expect(Main.sayGoodbye).to output("Goodbye and thank you for using book search!")
#     end
#   end
# end
# end


describe Main do
  describe ".clearTerminal" do
    context "When invoked" do
      it "clears everything from the console" do
        expect(Main.clearTerminal).to output("")
      end
    end
  end
end

describe Main do
  describe ".rspecTest" do
    context "when invoked" do
      it "returns 0" do
        expect(Main.rspecTest).to eql(0)
      end
    end
  end
end
