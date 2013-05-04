require 'test_helper'

class CartTest < ActiveSupport::TestCase

  setup do
    @cart = carts(:one)
  end

  test "should add product as a line item" do
    product = products(:one)

    add_product products(:one).id

    assert_equal 1, @cart.line_items.count
    assert_equal 1, @line_item.quantity
  end

  test "should add a 2nd product line item" do
    add_product products(:one).id
    add_product products(:two).id

    assert_equal 2, @cart.line_items.count
    assert_equal 1, @line_item.quantity
  end

  test "adding an already existing product will increment quantity" do
    product = products(:one)

    add_product(product.id)
    add_product(product.id)

    assert_equal 1, @cart.line_items.count
    assert_equal 2, @line_item.quantity
  end

  private
  def add_product(product_id)
    @line_item = @cart.add_product(product_id)
    @cart.save!
  end
end
