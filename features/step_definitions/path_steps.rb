require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

#FIXME GC 04/09/2010 - Should match either a digit or a valid label
Then(/^(.+?) should match route \/(.+?)$/) do |page, route|
  regexp = route.gsub(/:(\w*?)id/,'(?:\d+|[A-Za-z0-9_-]+)')
  path_to(page).should =~ /#{regexp}/
end

When(/^I go to (.+)$/) do |page|
  visit path_to(page)
end

Then(/^I should be at (.+)$/) do |page|
  request.path.should =~ /#{path_to(page)}/
end