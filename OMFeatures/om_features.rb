class String
  def remove_invalid_chars
    self.gsub(/[^\w\s]/, "")
  end
end

class Aggregator
  attr_reader :title, :body, :parent
  def initialize(hash)
    @title  = hash[:title]
    @body   = hash[:body]
    @parent = hash[:parent]
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
      :strings  => [body],
      :keyword  => "Scenario:",
      :create   => Scenario,
      :parsing  => self
    })
    @scenarios = parser.parse
  end
  
  def to_s
    <<-END
    @interface #{test_case_name} : OMFeature
    @end
    @implementation #{test_case_name}
    #{scenarios.map {|s| s.to_s}.join(" ")}
    @end
    END
  end
  
  def test_case_name
    "#{title.remove_invalid_chars.split(/\s+/).map {|w| w.capitalize}.join('')}Test"
  end
end

class Scenario < Aggregator
  attr_reader :steps, :lines
  def aggregate
    
    if Scenario.has_given_scenarios?(body)
      @body = Scenario.expand_given_scenarios_in_body(self)
    end
    
    
    @lines = body.split(/\n+/).map {|s| s.strip}
    raise "No Steps found" if lines.empty?
    
    @steps = parse_lines
  end
  
  def Scenario.expand_given_scenarios_in_body(scenario)
    scenario.body.gsub(/GivenScenario:(.*)/) do |m|
      existing_scenario = scenario.parent.scenarios.detect {|s| s.title == $1.strip }
      existing_scenario ? existing_scenario.body.strip : ""
    end
  end
  
  def parse_lines
    lines.map {|l| Step.new({:title => l, :body => l})}
  end
  
  def Scenario.has_given_scenarios?(body)
    !!(body =~ /GivenScenario:(.*)/)
  end
  
  def to_s
    <<-END
    -(void) #{test_name}
    {
        #{steps.map {|s| s.to_s}.join(" ")}
    }
    END
  end
  
  def test_name
    "test#{title.remove_invalid_chars.split(/\s+/).map {|w| w.capitalize}.join('')}"
  end
end

class Step < Aggregator
  attr_reader :message
  def aggregate
    @message = first_part + args_string
  end
  
  def first_part
    body.gsub(/\s+/,"_").gsub(/'[^']*'/, "__").remove_invalid_chars
  end
  
  def has_args?
    !args.empty?
  end
  
  def args
    @args ||= body.scan(/'([^']*)'/).map {|a| a[0]}
  end
  
  def args_string
    if has_args?
      ([":@\"#{args[0]}\""] + 
      (args[1..args.length] || []).map { |a| "arg:@\"#{a}\"" }).join(" ")
    else
      ""
    end
  end
  
  def to_s
    "[self #{message}];"
  end
  
  def parameter_string
    if has_args?
      s = ":(NSString *)arg "
      (args[1..args.length] || []).each_with_index do |a, i|
        s << "arg:(NSString *)arg#{i+2} "
      end
      s
    else
      ""
    end
  end
  
  def to_ocmethod
    <<-END
-(void) #{first_part + parameter_string}
{
  
}
    END
  end
end


class Parser
  attr_reader :string, :keyword, :create, :parsing
  def initialize(hash)
    @string  = hash[:strings].join(" ")
    @keyword = hash[:keyword]
    @create  = hash[:create]
    @parsing = hash[:parsing]
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
      created << create.new({:title => t, :body => bodies[i], :parent => parsing})
    end
    created
  end
  
  def parse_titles
    string.scan(/#{keyword}(.*)/).map {|a| a[0].strip}
  end
  
  def parse_bodies
    bodies = string.split(/(#{keyword}.*)/).select {|s| !s.empty? }.map {|s| s.strip}
    start = 0
    bodies.each_with_index do |o,i| 
      if (o =~ /^\s*#{keyword}.*\s*$/)
        start = i
        break
      end
    end
    bodies[start..bodies.length].select {|s| !(s =~ /#{keyword}.*/) }
  end
end

class Suite
  attr_reader :feature_files, :feature_files_path, 
              :feature_file_suffix, :feature_files_as_strings,
              :parser, :features, :test_cases_file, :feature_class_header_files
  
  def initialize(hash)
    @feature_files_path         = hash[:feature_files_path]
    @feature_file_suffix        = hash[:feature_file_suffix] || "feature"
    @test_cases_file            = hash[:test_cases_file]
    @feature_class_header_files = hash[:feature_class_header_files] || ["OMFeature.h"]
    @feature_files              = all_feature_files
    @feature_files_as_strings   = all_feature_files_as_strings
    @parser                     = Parser.new({ 
                                  :strings => @feature_files_as_strings,
                                  :keyword => "Feature:",
                                  :create  => Feature,
                                  :parsing => self})
                                  
    @features = parsed_features
    
    File.open(test_cases_file, "w") { |f| f.puts self }
  end
  
  def to_s
    <<-END
    #{feature_class_header_files.map { |f| "#import \"" + f + "\"" }.join(" ")}
    #{features.map {|f| f.to_s }.join(" ")}
    END
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