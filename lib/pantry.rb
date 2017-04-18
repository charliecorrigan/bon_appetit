class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
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
end
