# example of making your own matcher with the pickle backend
Then(/^#{capture_model} should be step of #{capture_model}$/) do |step, recipe|
  model(recipe).steps.should include(model(step))
end

# ((?:(?:\w+: (?:(?:(?:I|killah fork)|(?:(?:a|an|another|the|that) )?(?:(?:(?:(?:first|last|(?:\d+(?:st|nd|rd|th))) )?(?:step|recipe|ingredient))|(?:(?:step|recipe|ingredient)(?::? "(?:[^\"]|\.)*"))))|(?:"(?:[^\"]|\.)*"|nil|true|false|[+-]?\d+(?:\.\d+)?))), )*(?:\w+: (?:(?:(?:I|killah fork)|(?:(?:a|an|another|the|that) )?(?:(?:(?:(?:first|last|(?:\d+(?:st|nd|rd|th))) )?(?:step|recipe|ingredient))|(?:(?:step|recipe|ingredient)(?::? "(?:[^\"]|\.)*"))))|(?:"(?:[^\"]|\.)*"|nil|true|false|[+-]?\d+(?:\.\d+)?))))