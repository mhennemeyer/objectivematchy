class Feature
  attr_reader :title, :body
  def initialize(hash)
    @title = hash[:title]
    @body  = hash[:body]
  end
end


class Parser
  attr_reader :string
  def initialize(array_of_strings)
    @string = array_of_strings.inject("") do |m, o|
      m << o
    end
    raise "No Features given." unless /Feature:(.*)/.match(string)
  end
  
  def parse
    []
  end
end


class FeatureParser < Parser
  def parse

    titles = parse_titles
    bodies = parse_bodies
    
    # todo validate
    
    features = []
    titles.each_with_index do |t,i|
      features << Feature.new({:title => t, :body => bodies[i]})
    end
    features
  end
  
  def parse_titles
    string.scan(/^\s*Feature:(.*)$/).map {|a| a[0].strip}
  end
  
  def parse_bodies
    string.split(/^\s*Feature:.*\s*$/).select {|s| !s.empty? }.map {|s| s.strip}
  end
end


class Suite
  attr_reader :feature_files, :feature_files_path, 
              :feature_file_suffix, :feature_files_as_strings,
              :feature_parser, :features
  
  def initialize(hash)
    @feature_files_path       = hash[:feature_files_path]
    @feature_file_suffix      = hash[:feature_file_suffix]
    @feature_files            = all_feature_files
    @feature_files_as_strings = all_feature_files_as_strings
    @feature_parser           = FeatureParser.new(@feature_files_as_strings)
    @features                 = parsed_features
  end
  
  def parsed_features
    feature_parser.parse
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