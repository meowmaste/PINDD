require "test_helper"

feature "Auth / Signing Up" do
  scenario "new user can sign up" do
    visit root_path
    click_on "Sign up"
    fill_in "Email", with: "blah@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Sign up"
    page.text.must_include "You have signed up successfully"
  end

  scenario "duplicate user cannot sign up" do
    visit root_path
    click_on "Sign up"
    fill_in "Email", with: users(:lillian).email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Sign up"
    page.text.must_include "Email has already been taken"
  end
end
