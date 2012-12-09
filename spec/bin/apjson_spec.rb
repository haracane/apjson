require "spec_helper"

describe "bin/apjson" do
  input = [0,1,{"key"=>"val"}].to_json
  context "when option is not set" do
    context "when input is '#{input}'" do
      it "should print json with awesome_print" do
        result = `echo '#{input}' | #{Apjson::RUBY_CMD} #{Apjson::BIN_DIR}/apjson`
        result.should =~ /\[0\]/
        result.should =~ /\[1\]/
        result.should =~ /\[2\]/
        result.should =~ /0,/
        result.should =~ /1,/
        result.should =~ /"key" => "val"/
      end
    end

  end
  
  context "when using --p option" do
    context "when input is '#{input}'" do
      it "should print json with p" do
        result = `echo '#{input}' | #{Apjson::RUBY_CMD} #{Apjson::BIN_DIR}/apjson --p`
        result.chomp!
        result.should == "[0, 1, {\"key\"=>\"val\"}]"
      end
    end
  end

  context "when using --pp option" do
    context "when input is '#{input}'" do
      it "should print json with PrettyPrint" do
        result = `echo '#{input}' | #{Apjson::RUBY_CMD} #{Apjson::BIN_DIR}/apjson --pp`
        result.chomp!
        result.should == "[0, 1, {\"key\"=>\"val\"}]"
      end
    end
  end

  context "when using --puts option" do
    context "when input is '#{input}'" do
      context "when argument is not set" do
        it "should print json with puts" do
          result = `echo '#{input}' | #{Apjson::RUBY_CMD} #{Apjson::BIN_DIR}/apjson --puts`
          result = result.split()
          result.shift.should == "0"
          result.shift.should == "1"
          result.shift.should == "keyval"
          result.size.should == 0
        end
      end
      context "when argument is \"2 key\"" do
        it "should print \"val\"" do
          result = `echo '#{input}' | #{Apjson::RUBY_CMD} #{Apjson::BIN_DIR}/apjson --puts 2 key`
          result.chomp!
          result.should == "val"
        end
      end
    end
  end
  
end
