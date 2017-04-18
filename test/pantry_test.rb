require './lib/pantry'
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
end
