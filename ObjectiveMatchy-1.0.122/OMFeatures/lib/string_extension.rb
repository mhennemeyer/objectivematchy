class String
  def remove_invalid_chars
    self.gsub(/[^\w\s]/, "")
  end
  
  def only_whitespace?
    !!(self =~ /\A[\s]+\Z/)
  end
end