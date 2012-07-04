class CalculateController < ApplicationController
  layout 'common'

  def index
    if request.post?
      @loan_month = LoanMonth.from_params(params[:loan_month])
      session[:loan_month] = @loan_month
    else
      @loan_month = session[:loan_month] || LoanMonth.new(Time.now.month-1, 0, 0, 8.56, "", "", "", "")
    end
  end
end
