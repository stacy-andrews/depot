class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_line_item = line_items.find_by_product_id(product_id)

    if current_line_item
      current_line_item.quantity += 1
    else
      current_line_item = line_items.build(product_id: product_id)
    end

    current_line_item
  end
end
