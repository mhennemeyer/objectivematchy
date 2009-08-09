class Aggregator
  attr_reader :title, :body
  def initialize(hash)
    @title = hash[:title]
    @body  = hash[:body]
    raise "No title given" unless title
    raise "No body given" unless body
    aggregate
  end
  def aggregate
  end
end

class Feature < Aggregator
  attr_reader :scenarios
  def aggregate
    parser = Parser.new({
      :strings => [body],
      :keyword => "Scenario:",
      :create  => Scenario
    })
    @scenarios = parser.parse
  end
end

class Scenario < Aggregator
  attr_reader :steps
  def aggregate
    lines = body.split(/\n+/)
    raise "No Steps found" unless lines
    @steps = lines.map {|l| Step.new({:title => l, :body => l})}
  end
end

class Step < Aggregator
  attr_reader :message
  def aggregate
    args = body.scan(/'(.*)'/)
    
    @message = body.split(/\s+/).join("_")
  end
end


class Parser
  attr_reader :string, :keyword, :create
  def initialize(hash)
    @string  = hash[:strings].inject("") { |m, o| m << o }
    @keyword = hash[:keyword]
    @create  = hash[:create]
    raise "No Keyword given" unless keyword
    raise "No Class to create given" unless create
    raise "No #{@create.to_s} given." unless /#{@keyword}(.*)/.match(string)
  end
  
  def parse
    titles = parse_titles
    bodies = parse_bodies
    
    # todo validate
    
    created = []
    titles.each_with_index do |t,i|
      created << create.new({:title => t, :body => bodies[i]})
    end
    created
  end
  
  def parse_titles
    string.scan(/^\s*#{keyword}(.*)$/).map {|a| a[0].strip}
  end
  
  def parse_bodies
    bodies = string.split(/^\s*(#{keyword}.*)\s*$/).select {|s| !s.empty? }.map {|s| s.strip}
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

class Suite
  attr_reader :feature_files, :feature_files_path, 
              :feature_file_suffix, :feature_files_as_strings,
              :parser, :features
  
  def initialize(hash)
    @feature_files_path       = hash[:feature_files_path]
    @feature_file_suffix      = hash[:feature_file_suffix]
    @feature_files            = all_feature_files
    @feature_files_as_strings = all_feature_files_as_strings
    @parser                   = Parser.new({ 
                                  :strings => @feature_files_as_strings,
                                  :keyword => "Feature:",
                                  :create  => Feature})
    @features                 = parsed_features
  end
  
  def parsed_features
    parser.parse
  end
  
  def all_feature_files
    all_entries_in_feature_files_path = Dir.new(feature_files_path).entries
    feature_entries =  all_entries_in_feature_files_path.select do |file|
      !!(file =~ /\.#{feature_file_suffix}$/)
    end
    feature_entries.map do |file|
      feature_files_path + "/" + file
    end
  end
  
  def all_feature_files_as_strings
    feature_files.map do |file|
      feature_string = ""
      File.open(file) do |f|
        f.readlines.each do |l|
          feature_string << l
        end
      end
      feature_string
    end
  end
end