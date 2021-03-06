require 'pry'
class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(item)
    if stock[item].nil?
      return 0
    else
      return stock[item]
    end
  end

  def restock(item, amount)
    if stock[item].nil?
      @stock[item] = amount
    else
      current_amount = stock[item]
      @stock[item] = amount + current_amount
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.keys.each do |item|
      if shopping_list[item].nil?
        @shopping_list[item] = recipe.ingredients[item]
      else
        current_amount = shopping_list[item]
        @shopping_list[item] = recipe.ingredients[item] + current_amount
      end
    end
  end

  def print_shopping_list
    printed_list = ""
    shopping_list.each do |item|
      printed_list += "* #{item[0]}: #{item[1]}\n"
    end
    printed_list.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook.push(recipe)
  end

  def what_can_i_make
    recipes_i_can_make = cookbook.map do |recipe|
      enough_ingredients = recipe.ingredients.map do |key, value|
        value <= stock[key]
      end
      can_make = enough_ingredients.all? do |value|
        value == true
      end
      if can_make
        recipe.name
      end
    end
    recipes_i_can_make.compact
  end
end
