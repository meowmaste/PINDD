require "test_helper"

feature "Notes / Character Countdown" do

  scenario "user can see character countdown when creating a note", js: true do
    sign_in
    visit new_note_path
    page.driver.execute_script("updateCountdown();")
    assert page.has_content?("140 characters remaining")
    fill_in "note_content", with: "MEOW MIX MEOW MIX PLEASE DELIVER!"
    page.driver.execute_script("updateCountdown();")
    assert page.has_content?("107 characters remaining")
  end

  scenario "user can see character countdown when editing a note", js: true do
    sign_in(:joslyn)
    visit edit_note_path(notes(:jnote))
    page.driver.execute_script("updateCountdown();")
    page.text.must_include "118 characters remaining"
    fill_in "note_content", with: "MEOW MIX MEOW MIX PLEASE DELIVER!"
    page.driver.execute_script("updateCountdown();")
    page.text.must_include "107 characters remaining"
  end
end
