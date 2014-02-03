require "test_helper"

feature "Auth / Signing Out" do
  scenario "registered user can sign in and out" do
    sign_in
    click_on "logout"
    page.text.must_include "You need to sign in or sign up before continuing"
  end
end
