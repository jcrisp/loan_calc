class CreateLoanMonths < ActiveRecord::Migration
  def self.up
    create_table :loan_months do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :loan_months
  end
end
