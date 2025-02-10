class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :number, null: false
      t.date :date, null: false
      t.date :due_date, null: false
      t.string :client_name, null: false
      t.string :client_email
      t.decimal :total_amount, precision: 10, scale: 2, default: 0
      t.string :status, default: 'draft'

      t.timestamps
    end
    
    add_index :invoices, :number, unique: true
  end
end