Feature: I can easily create models from dupe
  As a pickle user
  I want to be able to leverage my factories
  So that I can create models quickly and easily in my features
  
  Scenario: I create a recipe, and see if it looks right
    Given a recipe exists
    Then a recipe should exist
  
	@basic_test
  Scenario: I create a recipe with specific name, and see if it looks right
    Given a recipe exists with name: "Chicken Recipe"
    Then a recipe should exist with name: "Chicken Recipe"
  
  Scenario: I create stub recipes, and see if it looks right
    Given 3 recipes exist
	  Then 3 recipes should exist
	
	@many_to_one_association
	Scenario: I create some recipes, and some steps
	  Given a recipe: "one" exists
	  And a step exists with recipe: recipe "one"
	  And another step exists with recipe: recipe "one"
	  And a recipe: "two" exists
	  And a step exists with recipe: recipe "two"

    # TODO: GC 02/05/2010 named factory definition is not yet supported by dupe
    # And a fancy recipe exists
    # And an ingredient exists with recipe: the fancy recipe
    
    # testing custom step
	  Then the first step should be step of the recipe: "one"
	  And the 2nd step should be step of recipe "one"
	  And the last step should be step of recipe "two"
	  
	  Then the first step should be in recipe "one"'s steps
	  And the 2nd step should be in recipe: "one"'s steps
	  And the last step should be in recipe "two"'s steps
	  And recipe "two" should be the last step's recipe
	  
	  #But the first ingredient should not be in the fancy recipe's ingredients
	  But the last step should not be in recipe "one"'s steps
	  And recipe "two" should not be the first step's recipe
	  #And the fancy recipe should not be the first ingredient's recipe
	
  @many_to_many_association
	Scenario: I create some ingredients and associate to some recipe
	  Given an ingredient: "one" exists
	  And an ingredient: "two" exists
	  And a recipe exists with ingredients: ingredient "one"
	  And a recipe exists with ingredients: [ingredient "one", ingredient "two"]
	  Then the first recipe should be in ingredient "one"'s recipes
	  And the last recipe should be in ingredient "one"'s recipes
	  And the last recipe should be in ingredient "two"'s recipes
	  And the first recipe should not be in ingredient "two"'s recipes

  Scenario: Create an ingredient and a recipe refs in a table
    Given 2 recipes exist
    And the following ingredients exist:
      | recipe      |
      | the 1st recipe |
      | the 2nd recipe |
    Then the 1st ingredient should be in the 1st recipe's ingredients
    And the 2nd ingredient should be in the 2nd recipe's ingredients