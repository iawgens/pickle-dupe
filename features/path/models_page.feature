Feature: I can visit a page for a model
  In order to easily go to pages for models I've created
  As a feature writer
  I want to be able visit pages their model

  Scenario: create a recipe, go its page
    Given a recipe exists
    When I go to the recipe's page
    Then I should be at the recipe's page
    And the recipe's page should match route /recipes/:id
    
  Scenario: create a recipe, go to its edit page, check lots of different refs to it
    Given a recipe: "chicken fingers" exists
    When I go to recipe: "chicken fingers"'s edit page
    Then I should be at the 1st recipe's edit page
    And the 1st recipe's edit page should match route /recipes/:id/edit
    And the recipe's edit page should match route /recipes/:id/edit
    And the recipe: "chicken fingers"'s edit page should match route /recipes/:id/edit  
    
  Scenario: go to a recipe's nested ingredients page
    Given a recipe exists
    When I go to the recipe's ingredients page
    Then I should be at the recipe's ingredients page
    And the recipe's ingredients page should match route /recipes/:recipe_id/ingredients
  
  Scenario: go to a recipe's new ingredient page
    Given a recipe exists
    When I go to the recipe's new ingredient page
    Then I should be at the recipe's new ingredient page
    And the recipe's new ingredient page should match route /recipes/:recipe_id/ingredients/new
    
  Scenario: go to a ingredient in recipe context page
    Given a recipe exists
    And an ingredient exists with recipe: the recipe
    When I go to the recipe's ingredient's page
    Then I should be at the recipe's ingredient's page
    And the recipe's ingredient's page should match route /recipes/:recipe_id/ingredients/:id
    
  Scenario: go to a ingredient's comments in recipe context
    Given a recipe exists
    And an ingredient exists with recipe: the recipe
    When I go to the recipe's ingredient's comments page
    Then I should be at the recipe's ingredient's comments page
    And the recipe's ingredient's comments page should match route /recipes/:recipe_id/ingredients/:ingredient_id/comments