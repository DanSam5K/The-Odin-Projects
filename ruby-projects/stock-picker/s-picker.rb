def stock_picker (prices)
  max_profit = 0
  buy_day = 0
  sell_day = 0
  prices.each_with_index do |buy_price, buy_index|
    prices.each_with_index do |sell_price, sell_index|
      if sell_index > buy_index
        profit = sell_price - buy_price
        if profit > max_profit
          max_profit = profit
          buy_day = buy_index
          sell_day = sell_index
        end
      end
    end
  end
  return [buy_day, sell_day]
end

# Test
p stock_picker([17,3,6,9,15,8,6,1,10])

