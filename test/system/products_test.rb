require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url # "/"
    assert_selector "h1", text: "Awesome Products"
    assert_selector ".card-product", count: Product.count
  end

  test "lets a signed in user try again after submitting a bad form" do
    login_as users(:george)
    visit "/products/new"
    # George fills in the form badly
    fill_in "product_tagline", with: "Change your life: Learn to code"

    # George submits bad form
    click_on 'Create Product'

    # George should be stuck in the create path and seeing the name validation error message
    assert_equal "/products", page.current_path
    assert_text "Name can't be blank"

    # George fixes his mistake
    fill_in "product_name", with: "Le Wagon"
    # And tries to submit again
    click_on 'Create Product'

    # Should be redirected to Home with new product
    assert_equal root_path, page.current_path
    save_and_open_screenshot
    assert_text "Change your life: Learn to code"
  end
end
