require "application_system_test_case"

class LinkTest < ApplicationSystemTestCase
  setup do
    @first_link = links(:first)
    @second_link = links(:second)

    @first_link.update(user_id: users(:first).id)
    @second_link.update(user_id: users(:first).id)
  end

  test "sign_in" do
    sign_in
    assert current_url, "/links"
  end

  test "visit_links" do
    sign_in
    assert_button "Save"
  end

  test "check_links" do
    sign_in
    prefix_name = "link_"
    elements = all("[id^='#{prefix_name}']")

    assert_equal elements.count, 2
  end
end