require 'test_helper'
require File.join(Rails.root, 'db', 'migrate', '20130428013604_combine_items_in_cart')

class CombineItemsInCartTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:multiple_line_items)
  end

  test "down splits line items with multiple quantities into multiple singles" do
    migration = CombineItemsInCart.new
    migration.down

    assert_equal 4, @cart.line_items.count
  end

  test "down does not affect line items with a single quantity" do
    @line_items_with_one = LineItem.where(quantity=1).select(:id)

    migration = CombineItemsInCart.new
    migration.down

    @line_items_with_one.each do |line_item_id|
      assert_equal 1, LineItem.find(line_item_id).quantity
    end
  end 
end