require "application_system_test_case"

class LinkTest < ApplicationSystemTestCase
  test "sign in" do
    sign_in
    assert current_url, "/links"
  end

  test "visit links" do
    sign_in
    assert_button "Save"
  end

  test "check saved links" do
    sign_in
    prefix_name = "link_"
    elements = all("[id^='#{prefix_name}']")

    assert_equal elements.count, 2
  end

  test "create link" do
    sign_in
    click_on "Save"
    fill_in "link_url", with: "https://github.com"
    click_on "link-submit-button"

    assert_text "GitHub: Let’s build from here · GitHub"
  end

  test "delete link" do
    sign_in
    click_on "Save"
    fill_in "link_url", with: "https://openai.com"
    click_on "link-submit-button"
    within("#links") do
      assert_link(href: "https://openai.com")
    end

    first("#link-delete-button").click
    page.accept_alert
    within("#links") do
      assert_no_link(href: "https://openai.com")
    end
  end

  test "copy link" do
    sign_in
    click_on "Save"
    fill_in "link_url", with: "https://openai.com"
    click_on "link-submit-button"

    first("#link-share-button").click
    assert_text "Copied"
  end
end