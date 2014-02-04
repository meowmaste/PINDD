require "test_helper"

feature "Notes / Deleting A Note" do
  scenario "unauthorized site visitor cannot delete note" do
    visit notes_path
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content "Destroy"
  end

  scenario "user can delete note that she owns" do
    sign_in(:lillian)
    visit notes_path
    page.find("a[href='#{note_path(notes(:lnote))}'][data-method='delete']").click
    page.text.wont_include notes(:lnote).content
    page.text.must_include notes(:jlnote).content
  end

  scenario "user cannot delete note that she doesn't own" do
    sign_in(:lillian)
    visit notes_path
    page.find("a[href='#{note_path(notes(:jnote))}'][data-method='delete']").click
    click_on "logout"

    sign_in(:joslyn)
    visit notes_path
    page.text.must_include notes(:jnote).content
  end
end
