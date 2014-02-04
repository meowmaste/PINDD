require "test_helper"

feature "Notes / Creating A Note" do
  scenario "unauthorized site visitor cannot create notes" do
    visit new_note_path
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content "Create Note"
  end

  scenario "user can create notes" do
    sign_in
    click_on "New Note"
    fill_in "note_content", with: "YAYAYAY!!!"
    click_on "Create Note"
    page.text.must_include "YAYAYAY!!!"
    page.text.must_include "Note was successfully created"
  end
end
