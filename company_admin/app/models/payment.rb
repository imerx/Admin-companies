class Payment < ActiveRecord::Base
    
  belongs_to :company
  belongs_to :expense
  validates_presence_of :expense_id,:amount, presence: true,  :message => "No puede ir en blanco"  
  
  scope :hoy, -> { where(created_at: Date.today) }
   
  scope :current_week, -> {
     start = Time.zone.now
     where(created_at: start.beginning_of_week..start.end_of_week).order("created_at desc")
     }
  scope :current_month, -> {
     start =Time.zone.now
     where(created_at: start.beginning_of_month..start.end_of_month).order("created_at desc")
     }

end