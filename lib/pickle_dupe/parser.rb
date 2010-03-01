module Pickle
  class Parser
    def parse_field_with_multi_values(field)
      # Would handle multiple values like "ingredients: [ingredient \"one\", ingredient \"two"\]"
      if session && field =~ /^(\w+): #{match_model_in_values}$/
        field_key = $1
        
        models = []
        values = parse_values(field)
        values.each do |value|
          if value =~ /^#{capture_model}$/
            models << session.model($1)
          end
        end
    
        {field_key => models}
      else  
        parse_field_without_multi_values(field)
      end
      
    end
    
    alias_method_chain :parse_field, :multi_values
    
    def match_field
      "(?:\\w+: #{match_values})"
    end
    
    def match_value
      "(?:#{match_model}|\"#{match_quoted}\"|nil|true|false|[+-]?\\d+(?:\\.\\d+)?)"
    end
    
    def match_values
      # like [step "one", step "two"]
      "(?:\\[?(?:#{match_value}, )*#{match_value}\\]?)"
    end
    
    def match_model_in_values
      "\\[?(?:#{match_model}, )*#{match_model}\\]?"
    end
  
  private
    
    # Given field of "ingredients: [ingredient \"one\", ingredient \"two\"]" return
    # ["ingredient \"one\"","ingredient \"two\""]
    def parse_values(field)
      if field =~ /^\w+: (#{match_values})$/
        $1.scan(/(#{match_value})(?:,|$|\])/).inject([]) do |m, match|
          m << match[0]
        end
        #TODO GC 02/26/2010 - What to do if it does not match the values pattern?
      end
    end
      
  end
end