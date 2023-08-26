require "test_helper"

class GameMatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_matches_index_url
    assert_response :success
  end

  test "should get show" do
    get game_matches_show_url
    assert_response :success
  end
end
