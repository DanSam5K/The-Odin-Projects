class Account
  attr_reader :name
  attr_reader :balance

  def initialize(name, balance=100)
    @name = name
    @balance = balance
  end

  def display_balance(pin_number)
    if pin_number == pin
      puts "Balance: $#{@balance}."
    else
      puts pin_error
    end
  end

  def withdraw(pin_number, amount)
    if pin_number == pin && @balance >= amount
      @balance -= amount
      puts "Withdrew #{amount}. New balance: $#{@balance}."
    elsif amount > @balance && pin_number == pin
      puts overdraft_error
    else
      puts pin_error
    end
  end

  def deposit(pin_number, amount)
    if pin_number == pin
      @balance += amount
      puts "Deposited #{amount}. New balance: $#{@balance}."
    else
      puts pin_error
    end
  end
  
  private
  def pin
    @pin = 1234
  end

  def pin_error
    return "Access denied: incorrect PIN."
  end

  def overdraft_error
    return "Insufficient funds. You have $#{@balance} in your account."
  end
end

class SavingsAccount < Account
end

checking_account = Account.new("Daniel", 2_000_000)
checking_account.display_balance(1234)
checking_account.withdraw(1234, 10_000)

savings_account = SavingsAccount.new("Daniel", 1_000_000)
savings_account.display_balance(1234)
savings_account.withdraw(1234, 50_000)