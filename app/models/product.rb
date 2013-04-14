class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  validates_presence_of :title, :description, :image_url
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)$}i, message: 'must be a URL for GIF, JPG or PNG image.'}
  validates_length_of :title, :minimum => 10
end
