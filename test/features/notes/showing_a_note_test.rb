require "test_helper"

feature "Notes / Showing A Note" do
  scenario "unauthorized site visitor cannot view notes" do
    visit notes_path
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content notes(:lnote).content

    visit note_path(notes(:lnote))
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content notes(:lnote).content
  end

  scenario "user can see notes she owns" do
    sign_in(:lillian)
    visit notes_path
    page.text.must_include notes(:lnote).content

    visit note_path(notes(:lnote))
    page.text.must_include notes(:lnote).content
  end

  scenario "user cannot see notes she doesn't own" do
    sign_in(:lillian)
    visit notes_path
    page.text.wont_include notes(:jnote).content

    visit note_path(notes(:jnote))
    page.text.must_include "You are not authorized to access this page"
    page.text.wont_include notes(:jnote).content
  end

  scenario "user can see notes for group she belongs to" do
    sign_in(:lillian)
    visit notes_path
    page.text.must_include notes(:jlnote).content

    visit note_path(notes(:jlnote))
    page.text.must_include notes(:jlnote).content
  end

  scenario "user can see use filter to select which groups to show", js: true do
    sign_in(:lillian)
    visit notes_path
    page.text.must_include notes(:lnote).content
    page.text.must_include notes(:jlnote).content
    save_and_open_page
    #within '#group-form' do
      uncheck("input[type='checkbox']")
      #uncheck('#g_'+groups(:joslyn_lillian).id.to_s)
    #end
    trigger_change("g_"+groups(:joslyn_lillian).id.to_s)
    page.text.must_include notes(:lnote).content
    page.text.wont_include notes(:jlnote).content
  end
end
