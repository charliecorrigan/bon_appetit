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

  def test_stock_check_returns_accurate_inventory
    pantry = Pantry.new
    output = pantry.stock_check("Cheese")
    assert_equal 0, output
  end

end
