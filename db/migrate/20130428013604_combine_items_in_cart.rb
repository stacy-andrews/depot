class CombineItemsInCart < ActiveRecord::Migration
  def up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all

          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
    #turn line items with multiple quantities into multiple line items
    Cart.all.each do |cart|
      cart.line_items.where("quantity > 1", 1).each do |line_item|
        line_item.quantity.times do |quantity|
          cart.line_items.create(product_id: line_item.product_id, quantity: 1)
        end

        line_item.destroy
      end
    end
  end
end
