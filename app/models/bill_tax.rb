class BillTax < ActiveRecord::Base
  
  before_save :generate_tax_name
 # before_save :generate_bill_id
  before_save :generate_tax
  before_save :generate_tax_type_of_tax
  #after_save :generate_tax_amount
  #after_commit :generate_tax_amount
  
  belongs_to :tax
  belongs_to :bill
  belongs_to :line_item
  
  def generate_tax_name
    self.tax_name = self.tax.tax_name
  end
  
  def generate_bill_id
   # if self.line_item.present?
     self.bill_id = self.line_item.bill.id
   # end
  end
  
  def generate_tax
    self.tax_type = self.tax_name + " " + self.tax_rate.to_s
  end
  
  def generate_tax_type_of_tax
    if self.tax.tax_type == "Percentage"
      self.tax_type_of_tax = self.tax_type + " " + "%"
    elsif self.tax.tax_type == "Flat Amount"
      self.tax_type_of_tax = self.tax_type + " " +"(Amount)"
    end
  end

 #bill = self.bill
      #line_item = self.line_item
      #bill_taxes_of_line_item = line_item.bill_taxes
      #tax_type = self.tax.tax_type
      #tax_on_tax = self.tax.tax_on_tax
      #tax_amount = bill_taxes_of_line_item.where.not(:tax_name => ["VAT", "CST"]).sum(:tax_amount)
      #total_price = line_item.total_price
end
