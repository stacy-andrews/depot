require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: {  }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    show 
    assert_response :success
  end

  test "fixture - cart with items" do
    cart = carts(:with_products)

    assert cart.line_items.any?
  end

  # test "should show all line items in cart" do
  #   cart = carts(:with_products)
  #   show cart

  #   assert_response :success
  #   assert_select ' .cart_item', cart.line_items.count
  # end

  def show(cart = nil)
    if (cart == nil)
      cart = @cart
    end

    get :show, id: cart
  end

  test "should get edit" do
    get :edit, id: @cart
    assert_response :success
  end

  test "should update cart" do
    put :update, id: @cart, cart: {  }
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy the current users cart" do
    assert_difference('Cart.count', -1) do
      session[:cart_id] = @cart.id
      delete :destroy, id: @cart
    end

    # todo - put in own test
    assert_redirected_to store_path
end

test "invalid cart ids will redirect back to the store" do
  get_invalid_cart

  assert_redirected_to store_path
end

test "invalid cart ids will show an invalid cart message" do
  get_invalid_cart

  assert_equal "Invalid cart", flash[:notice]
end

private 
def get_invalid_cart 
  get :show, id: 3456
end
end