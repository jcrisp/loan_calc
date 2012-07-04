class LoanMonth < Struct.new(:month, :repayment, :balance, :interest_rate, :interest_rate2, :rate2_start_day, :extra_repayment, :extra_repayment_day, :interest, :new_balance)

  DAYS_IN_MONTH = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  DAYS_IN_YEAR = 365

  def self.from_params(params)
    result = LoanMonth.new
    params.keys.each do |k| 
      if k.ends_with?("day") || k == "month"
        result[k] = params[k].to_i unless params[k] == ""
      else
        result[k] = params[k].to_f unless params[k] == ""
      end
    end
    result
  end

  def amount_repaid
    repayment - interest
  end

  def interest
    total = 0
    (1..DAYS_IN_MONTH[month-1]).each do |d|
      total += rate_on_day(d) * balance_on_day(d) 
    end
    total / 100 / DAYS_IN_YEAR
  end

  def new_balance
    balance - amount_repaid - extra_repayment.to_f
  end

  def rate_on_day(day_num)
    if !has_rate2
      interest_rate
    else
      day_num < rate2_start_day ? interest_rate : interest_rate2
    end
  end

  def balance_on_day(day_num)
    if !has_extra_repayment
      balance
    else
      day_num < extra_repayment_day ? balance : balance - extra_repayment
    end
  end

  def has_rate2
    !empty?(interest_rate2) && !empty?(rate2_start_day)
  end

  def has_extra_repayment
    !empty?(extra_repayment) && !empty?(extra_repayment_day)
  end

  def empty?(v)
    v == nil || v == "" || v == 0
  end

end
