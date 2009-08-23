require File.dirname(__FILE__) + '/spec_helper'

describe "only_whitespace?" do

  it "is false for 'string'" do
    "string".only_whitespace?.should be_false
  end
  
  it "is false for ' string '" do
    " string ".only_whitespace?.should be_false
  end
  
  it "is false for ' string \n string'" do
    " string \n string".only_whitespace?.should be_false
  end
  
  it "is false for newline char newline" do
    "\na\n".only_whitespace?.should be_false
  end
  
  it "is false for space newline char newline space" do
    " \na\n ".only_whitespace?.should be_false
  end
  
  it "is false for a single char in a long string of mixed whitespace" do
    "\n\n  \t \t \n  a   \t\t\t \n\n   ".only_whitespace?.should be_false
  end
  
  it "is true for single space" do
    " ".only_whitespace?.should be_true
  end
  
  it "is true for single newline" do
    "\n".only_whitespace?.should be_true
  end
  
  it "is true for double space" do
    "  ".only_whitespace?.should be_true
  end
  
  it "is true for double newline" do
    "\n\n".only_whitespace?.should be_true
  end
  
  it "is true for mixed newlines spaces and tabs" do
    "\n\n  \t \t \n     \t\t\t \n\n   ".only_whitespace?.should be_true
  end
end