require 'pickle_dupe'

Pickle.configure do |c|
  c.adapters = [:dupe]
  c.map 'I', :to => 'user: "me"'
  c.map 'killah fork', :to => 'fancy fork: "of cornwood"'
end