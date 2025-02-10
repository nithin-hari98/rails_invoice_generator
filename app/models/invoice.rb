class Invoice < ApplicationRecord
    # 1. Associations
    has_many :line_items, dependent: :destroy
    accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank
    
    # 2. Validations
    validates :number, presence: true, uniqueness: true
    validates :date, :due_date, :client_name, presence: true
    validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
    validates :status, inclusion: { in: %w[draft sent paid cancelled] }
    
    # 3. Callbacks
    before_validation :set_invoice_number, on: :create
    
    # 4. Instance Methods
    def calculate_total
      self.total_amount = line_items.sum(&:total_price)
      save
    end
    
    private
    
    def set_invoice_number
      return if number.present?
      last_number = Invoice.maximum(:number)
      self.number = if last_number
                      "INV-#{(last_number.split('-').last.to_i + 1).to_s.rjust(6, '0')}"
                    else
                      "INV-000001"
                    end
    end
  end