json.extract! invoice, :id, :number, :date, :due_date, :client_name, :client_email, :total_amount, :status, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
