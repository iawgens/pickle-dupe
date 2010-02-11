Feature: I can easily create models from dupe
  As a pickle user
  I want to be able to leverage my factories
  So that I can create models quickly and easily in my features
  
  Scenario: I create a recipe, and see if it looks right
    Given a recipe exists
    Then a recipe should exist
    
  Scenario: I create a recipe with specific name, and see if it looks right
    Given a recipe exists with name: "Chicken Recipe"
    Then a recipe should exist with name: "Chicken Recipe"
  
  Scenario: I create stub recipes, and see if it looks right
    Given 3 recipes exist
	  Then 3 recipes should exist
	
	@association
	Scenario: I create some recipes, and some ingredients
	  Given a recipe: "one" exists
	  And an ingredient exists with recipe: recipe "one"
	  And another ingredient exists with recipe: recipe "one"
	  And a recipe: "two" exists
	  And an ingredient exists with recipe: recipe "two"
	  
    # TODO: GC 02/05/2010 named factory definition is not yet supported by dupe 
    # And a fancy recipe exists
    # And an ingredient exists with recipe: the fancy recipe
	  
	  Then the first ingredient should be ingredient of the recipe: "one"
	  And the 2nd ingredient should be ingredient of recipe "one"
	  And the last ingredient should be ingredient of recipe "two"
	  
	  Then the first ingredient should be in recipe "one"'s ingredients
	  And the 2nd ingredient should be in recipe: "one"'s ingredients
	  And the last ingredient should be in recipe "two"'s ingredients
	  And recipe "two" should be the last ingredient's recipe
	  
	  #But the first ingredient should not be in the fancy recipe's ingredients
	  But the last ingredient should not be in recipe "one"'s ingredients
	  And recipe "two" should not be the first ingredient's recipe
	  #And the fancy recipe should not be the first ingredient's recipe
 
  Scenario: Create an ingredient and a recipe refs in a table
    Given 2 recipes exist
    And the following ingredients exist:
      | recipe      |
      | the 1st recipe |
      | the 2nd recipe |
    Then the 1st ingredient should be in the 1st recipe's ingredients
    And the 2nd ingredient should be in the 2nd recipe's ingredients