class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.string :number
      t.date :date
      t.date :due_date
      t.string :client_name
      t.string :client_email
      t.decimal :total_amount
      t.string :status

      t.timestamps
    end
  end
end
