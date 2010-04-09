Feature: I can visit a page by named route
  In order to nav in my features
  As a feature writer
  I want to be able visit named routes
  
  @wip
  Scenario: visit the new spoons page
    When I go to the new recipe page
    Then I should be at the new recipe page
    And the new recipe page should match route /recipes/new
   