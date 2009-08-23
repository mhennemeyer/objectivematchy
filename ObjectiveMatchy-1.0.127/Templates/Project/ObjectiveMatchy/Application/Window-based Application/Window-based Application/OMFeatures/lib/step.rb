class Step 
  attr_reader :message
  
  attr_reader :title, :body, :parent
  def initialize(hash)
    @title  = hash[:title]
    @body   = hash[:body]
    @parent = hash[:parent]
    raise "No title given" unless title
    raise "No body given" unless body
  end
  
  def to_html
    s = <<-END
    <h3 class="step">#{title}</h3>
    END
    s.strip
  end
  
  def aggregate!
    @message = first_part + args_string
    self
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
