require 'test_helper'


class ExpenseTest < ActiveSupport::TestCase
    
    def setup
      @expense  = Expense.new(name: "Electricidad")
    end
    
    test "name should be valid" do
        assert @expense.valid?
    end
    
end