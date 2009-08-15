require File.dirname(__FILE__) + '/spec_helper'

describe "remove_invalid_chars" do
  %w(
  *
  -
  '
  !
  "
  $
  %
  &
  /
  {
  }
  ).each do |nw|
    it "removes #{nw}" do
      "Blah blah #{nw} blah Blah".remove_invalid_chars.should eql("Blah blah  blah Blah")
    end
  end
  
end