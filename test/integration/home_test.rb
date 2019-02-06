require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test 'loads correctly' do
    get root_path
    assert_response :success
    assert_select 'title', 'ProductHunt'
    assert_select 'h1', 'Products'
  end
end
