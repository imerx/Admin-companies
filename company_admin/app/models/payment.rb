class Payment < ActiveRecord::Base
    
  belongs_to :company
  belongs_to :expense
  validates_presence_of :expense_id,:amount, presence: true,  :message => "No puede ir en blanco"  
  
  scope :hoy, -> { where(created_at: Date.today) }
  

end