require "test_helper"

feature "Notes / Editing A Note" do
  scenario "unauthorize user cannot edit notes" do
    visit edit_note_path(notes(:lnote))
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content "Update Note"
  end

  scenario "user can edit note that she owns" do
    sign_in(:lillian)
    visit edit_note_path(notes(:lnote))
    fill_in "note_content", with: "Lillian's note has been edited!"
    click_on "Update Note"
    page.text.must_include "Note was successfully updated"
    page.text.must_include "Lillian's note has been edited!"
    visit edit_note_path(notes(:lnote))
    fill_in "note_content", with: ""
    click_on "Update Note"
  end

  scenario "user cannot edit note that she doesn't own" do
    sign_in(:lillian)
    visit edit_note_path(notes(:jnote))
    page.wont_have_content "Update Note"
    page.text.wont_include notes(:jnote).content
  end
end
