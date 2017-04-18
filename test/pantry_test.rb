require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new
    assert_instance_of Pantry, pantry
  end

  def test_pantry_stock_attribute
    pantry = Pantry.new
    output = pantry.stock
    assert_equal Hash, output.class
    assert output.empty?
  end

  def test_stock_check_returns_zero_when_empty
    pantry = Pantry.new
    output = pantry.stock_check("Cheese")
    assert_equal 0, output
  end

  def test_restock_adds_item_and_quantity_to_stock
    pantry = Pantry.new

    output_1 = pantry.stock
    assert output_1.empty?
    
    pantry.restock("Cheese", 10)
    
    output_2 = pantry.stock
    refute output_2.empty?
  end

  def test_stock_check_returns_stock_amount_when_item_is_in_stock
    pantry = Pantry.new
    
    output_1 = pantry.stock_check("Cheese")
    assert_equal 0, output_1
    
    pantry.restock("Cheese", 10)
    output_2 = pantry.stock_check("Cheese")
    assert_equal 10, output_2
  end

  def test_restock_adds_amount_to_item_instead_of_replacing_amount
    pantry = Pantry.new
    
    output_1 = pantry.stock_check("Cheese")
    assert_equal 0, output_1
    
    pantry.restock("Cheese", 10)
    output_2 = pantry.stock_check("Cheese")
    assert_equal 10, output_2

    pantry.restock("Cheese", 20)
    output_3 = pantry.stock_check("Cheese")
    assert_equal 30, output_3
  end

  def test_test_access_to_recipe_class_and_methods
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    assert_instance_of Recipe, r
    assert_instance_of Pantry, pantry
    assert_equal Hash, r.ingredients.class
    assert r.ingredients.empty?

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    output = r.ingredients
    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, output
  end

  def test_pantry_has_shopping_list_attribute
    pantry = Pantry.new
    output = pantry.shopping_list
    assert_equal Hash, output.class
    assert output.empty?
  end

  def test_add_to_shopping_list_accepts_recipe
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    output = pantry.add_to_shopping_list(r)
    refute output.nil?
    
  end

  def test_add_to_pantry_updates_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    
    output = pantry.shopping_list
    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, output
  end

  def test_add_to_pantry_updates_shopping_list_and_does_not_overwrite_previous_values
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)
    
    output_1 = pantry.shopping_list
    expected_1 = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected_1, output_1

    r = Recipe.new("Spaghetti")
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)

    output_2 = pantry.shopping_list
    expected_2 = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
    assert_equal expected_2, output_2
  end

  def test_print_shopping_list_returns_formatted_string
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    pantry.add_to_shopping_list(r)
    
    output = pantry.print_shopping_list
    expected = "* Cheese: 20\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    
    assert_equal expected, output
  end

  def test_pantry_has_cookbook_attribute
    pantry = Pantry.new
    output = pantry.cookbook
    assert_equal Array, output.class
    assert output.empty?
  end

  def test_add_recipe_to_cookbook
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_equal 3, pantry.cookbook.length
    assert_equal Recipe, pantry.cookbook.first.class
  end

  def test_what_can_i_make
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    output = pantry.what_can_i_make
    expected = ["Pickles", "Peanuts"]

    assert_equal expected, output
  end

end
