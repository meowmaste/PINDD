require "test_helper"

feature "Auth / Sign In" do
  scenario "registered user can sign in" do
    visit root_path
    fill_in "Email", with: users(:lillian).email
    fill_in "Password", with: "password"
    click_on "Sign in"
    page.text.must_include "Signed in successfully"
    page.text.must_include users(:lillian).email
  end

  scenario "unauthorized user cannot sign in" do
    visit root_path
    fill_in "Email", with: "blah@test.com"
    fill_in "Password", with: "password"
    click_on "Sign in"
    page.text.must_include "Invalid email or password"
    page.text.must_include "You are not signed in"
    page.text.wont_include "notes"
  end

end
