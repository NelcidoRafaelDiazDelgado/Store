require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      name: "Laptop",
      description: "Gaming laptop",
      price: 1200,
      sku: SecureRandom.uuid,
      amount: 10,
      min: 1,
      status: :active
    )
  end

  test "is valid with correct attributes" do
    assert @product.valid?
  end

  test "is invalid without amount" do
    @product.amount = nil
    assert_not @product.valid?
  end

  test "does not allow negative amount" do
    @product.amount = -5
    assert_not @product.valid?
  end

  test "does not allow price less than 1" do
    @product.price = 0
    assert_not @product.valid?
  end

  test "does not allow minimum less than 1" do
    @product.min = 0
    assert_not @product.valid?
  end

  test "status enum works correctly" do
    assert_equal Product.statuses, {
      "draft" => 0,
      "active" => 1,
      "archived" => 2,
      "out_of_stock" => 3
    }
  end

  test "can use enum helpers" do
    @product.status = :draft
    assert @product.draft?

    @product.status = :archived
    assert @product.archived?
  end
end
