class Feature 
  attr_reader :scenarios, :scenario_keyword,
              :title, :body, :parent, :parser,
              :given_scenario_keyword, :keyword
  
  def initialize(hash={})
    @title                  = hash[:title]
    @body                   = hash[:body]
    @parent                 = hash[:parent]
    @keyword                = hash[:keyword] || "Feature:"
    @scenario_keyword       = hash[:scenario_keyword] || "Scenario:"
    @given_scenario_keyword = hash[:given_scenario_keyword] || "GivenScenario:"
    
    raise "No title given" unless title
    raise "No body given" unless body
  end
  
  def story
    body.split(/#{scenario_keyword}/)[0].split(/#{keyword}\s#{title}/).join(" ").strip
  end
  
  def story_html
    story.split("\n").join(" <br />")
  end
  
  def parse_scenarios
    title_body_arr = Parser.title_and_body_by_keyword_from_string({
      :string => body,
      :keyword => scenario_keyword
    })
    @scenarios = title_body_arr.map {|hash| Scenario.new(hash.update({
      :parent => self,
      :given_scenario_keyword => given_scenario_keyword
    }))}
    @scenarios.each {|scenario| scenario.collect_steps}
    self
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
  
  def to_html
    <<-END
    <div class="feature">
      <h2 class="feature_title">#{keyword} #{title}</h2>
      <p class="story">
        #{story_html}
      </p>
      #{scenarios.map {|s| s.to_html }.join(" \n")}
    </div>
  END
  end
  
  def test_case_name
    "#{title.remove_invalid_chars.split(/\s+/).map {|w| w.capitalize}.join('')}Test"
  end
end