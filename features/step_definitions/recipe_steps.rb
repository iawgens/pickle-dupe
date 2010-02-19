# example of making your own matcher with the pickle backend
Then(/^#{capture_model} should be ingredient of #{capture_model}$/) do |ingredient, recipe|
  model(recipe).ingredients.should include(model(ingredient))
end

# ((?:(?:\w+: (?:(?:(?:I|killah fork)|(?:(?:a|an|another|the|that) )?(?:(?:(?:(?:first|last|(?:\d+(?:st|nd|rd|th))) )?(?:step|recipe|ingredient))|(?:(?:step|recipe|ingredient)(?::? "(?:[^\"]|\.)*"))))|(?:"(?:[^\"]|\.)*"|nil|true|false|[+-]?\d+(?:\.\d+)?))), )*(?:\w+: (?:(?:(?:I|killah fork)|(?:(?:a|an|another|the|that) )?(?:(?:(?:(?:first|last|(?:\d+(?:st|nd|rd|th))) )?(?:step|recipe|ingredient))|(?:(?:step|recipe|ingredient)(?::? "(?:[^\"]|\.)*"))))|(?:"(?:[^\"]|\.)*"|nil|true|false|[+-]?\d+(?:\.\d+)?))))