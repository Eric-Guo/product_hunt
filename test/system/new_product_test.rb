require 'application_system_test_case'

class NewProductTest < ApplicationSystemTestCase
  test 'create a new product' do
    visit new_product_path

    fill_in 'product_name', with: 'L'
    page.has_selector?('ul > li > mark')
    fill_in 'product_name', with: 'Le Wagon'
    page.has_no_selector?('ul > li > mark')
    fill_in 'product_tagline', with: 'Change your life: Learn to code'
    click_button 'Create Product'

    # Should be redirected to Home with new product
    assert_equal product_path(Product.last), page.current_path
    assert page.has_content?('Change your life: Learn to code')
  end
end
