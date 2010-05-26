require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe CSVHash do
  before(:all) do
    @csv_path = File.expand_path(File.join(File.dirname(__FILE__),'assets','test.csv'))
    @clean_csv_path = File.expand_path(File.join(File.dirname(__FILE__),'assets','clean_test.csv'))
  end
  
  describe "from_file" do
    before(:all) do
      @array, @columns = CSVHash.from_file(@csv_path)
    end
    
    it "should get correct column names (no spaces)" do
      @columns.should == ["one", "two", "foo__bar__three", "foo__bar__four", "foo__five", "bar__six", "nil", "bar__seven"]
    end
    
    it "should only include data rows" do
      @array.should have(2).rows_of_hashes
    end
    
    it "should parse properly" do
      first = {
        "one" => "1",
        "two" => "2",
        "foo" => {
          "bar" => {"three" => "3", "four" => "4"},
          "five" => "5"
        },
        "bar" => {"six" => "6", "seven" => "7"},
        "nil" => nil
      }
      @array.first.should == first
      
      second = {
        "one" => "14",
        "two" => "13",
        "foo" => {
          "bar" => {"three" => "12", "four" => "11"},
          "five" => "10"
        },
        "bar" => {"six" => "9", "seven" => "8"},
        "nil" => nil
      }
      @array.last.should == second
    end
  end
  
  
  it "should generate an expected file" do
    CSVHash.to_string(*CSVHash.from_file(@csv_path)).chomp.should == File.open(@clean_csv_path).read.chomp
  end
  
  it "should do a round trip" do
    pending "Desire to add nil columns"
    CSVHash.to_string(*CSVHash.from_file(@csv_path)).chomp.should == File.open(@csv_path).read.chomp
  end
end
