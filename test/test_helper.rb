ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def create_account
    visit "/signup"
    fill_in "user_username", with: users(:first).username
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_on "Create Account"
  end

  def sign_in
    visit "/signin"
    fill_in "username", with: users(:first).username
    fill_in "password", with: "password"
    click_on "Sign In"
  end
end
