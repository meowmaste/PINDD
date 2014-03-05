require "test_helper"

feature "Notes / Character Countdown" do

  scenario "user can see character countdown when creating a note", js: true do
    sign_in
    visit new_note_path
    page.text.must_include "140 characters remaining"
    fill_in "note_content", with: "MEOW MIX MEOW MIX PLEASE DELIVER!"
    page.text.must_include "107 characters remaining"
  end

  scenario "user can see character countdown when editing a note", js: true do
<<<<<<< HEAD
    require_js
    sign_in(:lillian)
=======
    sign_in(:joslyn)
>>>>>>> 2696156c134ccd38aeae0a6e36a021c69323b8f5
    visit edit_note_path(notes(:jnote))
    page.text.must_include "118 characters remaining"
    fill_in "note_content", with: "MEOW MIX MEOW MIX PLEASE DELIVER!"
    page.text.must_include "107 characters remaining"
  end
end
