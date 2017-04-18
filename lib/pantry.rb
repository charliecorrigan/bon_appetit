require 'pry'
class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
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
end
