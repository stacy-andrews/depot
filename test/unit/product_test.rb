require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do 
    product = Product.new

    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title:       "My Book Title", 
                          description: "yyy", 
                          image_url:   "zzz.jpg")

    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.all_price_errors

    product.price = 0
    assert product.invalid?

    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    product.price = 1
    assert product.valid?
  end

  test "image url must end in a known image format extension" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(image_url: name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(image_url: name).invalid?, "#{name} shouldn't be valid"
    end
  end

  def new_product(overrides)
    defaults = {
      title:       'Howdy',
      description: 'Howdy howdy',
      price:       1,
      image_url:   'a.gif'
    }

    defaults.merge! overrides

    Product.new(defaults)
  end
end

class HashTest < ActiveSupport::TestCase
  test "can combine 2 hashes with the 2nd values overwriting the first" do
    hash_one = { title: 'Howdy', description: 'Howdy howdy' }
    hash_two = { description: 'is different' }

    hash_three = hash_one.merge hash_two

    assert_equal hash_two[:description], hash_three[:description]
    assert_equal hash_one[:title], hash_three[:title]
  end
end

