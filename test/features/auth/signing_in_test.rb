require "test_helper"

feature "Auth / Sign In" do
  scenario "registered user can sign in" do
    sign_in
    page.text.must_include "Signed in successfully"
    page.text.must_include users(:user).email
  end

  scenario "unauthorized user cannot sign in" do
    visit root_path
    fill_in "Email", with: "blah@test.com"
    fill_in "Password", with: "password"
    click_on "Sign in"
    page.text.must_include "Invalid email or password"
    page.text.wont_include "notes"
  end

end
