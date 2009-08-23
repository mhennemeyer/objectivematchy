class Parser
  attr_reader :string, :keyword, :create, :parsing
  def initialize(hash)
    @string  = hash[:string]
    @keyword = hash[:keyword]
    raise "No Keyword given" unless keyword
    raise "Nothing to parse given" unless string
    raise "No #{keyword} given." unless /#{keyword}(.*)/.match(string)
  end
  
  def self.title_and_body_by_keyword_from_string(hash)
    parser = self.new(hash)
    titles = parser.parse_titles
    bodies = parser.parse_bodies
    arr = []
    titles.each_with_index do |t,i|
      arr << {:title => t, :body => bodies[i]}
    end
    arr
  end
  
  def parse_titles
    string.scan(/(^|\s+)#{keyword}(.*)/).map {|a| a[1].strip}
  end
  
  def parse_bodies
    bodies = string.split(/(^|\s+)(#{keyword}.*)/).reject {|s| s.empty? }.reject {|s| s.only_whitespace? }.map {|s| s.strip}
    start = 0
    bodies.each_with_index do |o,i| 
      if (o =~ /^\s*#{keyword}.*\s*$/)
        start = i
        break
      end
    end
    bodies[start..bodies.length].select {|s| !(s =~ /^\s*#{keyword}.*\s*$/) }
  end
end