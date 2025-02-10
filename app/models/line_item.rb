class LineItem < ApplicationRecord
  belongs_to :invoice
  
  validates :description, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, :total_price, numericality: { greater_than_or_equal_to: 0 }
  
  before_save :calculate_total_price
  after_save :update_invoice_total
  after_destroy :update_invoice_total
  
  private
  
  def calculate_total_price
    self.total_price = quantity * unit_price
  end
  
  def update_invoice_total
    invoice.calculate_total
  end
end