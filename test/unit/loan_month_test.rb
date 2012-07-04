require File.dirname(__FILE__) + '/../test_helper'

class LoanMonthTest < Test::Unit::TestCase
  def test_one_interest_rate_no_extra_repayment
    l = LoanMonth.new
    l.month = 1
    l.repayment = 1000
    l.balance = 100000
    l.interest_rate = 5.0
    assert_equal 424.66, l.interest.round_with_precision(2)
    assert_equal 575.34, l.amount_repaid.round_with_precision(2)
    assert_equal 99424.66, l.new_balance.round_with_precision(2)
  end
end
