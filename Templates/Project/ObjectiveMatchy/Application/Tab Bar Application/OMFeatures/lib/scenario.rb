class Scenario
  attr_reader :steps, :lines, :given_scenario_keyword,
              :title, :body, :parent, :passed
              
  def initialize(hash)
    @title  = hash[:title]
    @body   = hash[:body]
    @parent = hash[:parent]
    @given_scenario_keyword = hash[:given_scenario_keyword] || "GivenScenario:"
    
    raise "No title given" unless title
    raise "No body given" unless body
  end
  
  def keyword
    parent.scenario_keyword
  end
  
  def to_html
    <<-END
    <div class="scenario #{passed? ? "passed" : "failed"}">
      <h2 class="scenario_title">#{keyword} #{title}</h2>
      #{steps.map {|s| s.to_html}.join(" \n")}
    </div>
    END
  end
  
  def passed?
    !!@passed
  end
  
  def verify_status(results="")
    test_case_name = parent.test_case_name
    #Test Case '-[SayHelloTest testWithABlankObject]' failed (0.001 seconds).
    results =~ /Test\sCase\s'-\[#{test_case_name}\s#{test_name}\]'\s(\w+)/
    match = $1
    if match =~ /failed/
      @passed = false
    elsif match =~ /passed/
      @passed = true
    else
      raise "Can't read results File"
    end
  end
  
  def collect_steps
    
    if has_given_scenarios?
      @body = expand_given_scenarios_in_body.strip
    end
    
    
    @lines = body.split(/\n+/).map {|s| s.strip}
    raise "No Steps found" if lines.empty?
    
    @steps = parse_lines
    self
  end
  
  def expand_given_scenarios_in_body
    raise "No associated Feature" unless parent 
    raise "Associated Feature has no Scenarios" unless parent.scenarios
    body.gsub(/#{given_scenario_keyword}(.*)/) do |m|
      existing_scenario = parent.scenarios.detect {|s| s.title == $1.strip }
      existing_scenario ? existing_scenario.body.strip : ""
    end
  end
  
  def parse_lines
    lines.map {|l| Step.new({:title => l, :body => l}).aggregate!}
  end
  
  def has_given_scenarios?
    !!(body =~ /#{given_scenario_keyword}(.*)/)
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