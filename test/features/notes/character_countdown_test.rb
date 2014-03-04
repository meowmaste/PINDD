require "test_helper"

feature "Notes / Character Countdown" do
  before(:all) do
    Capybara.current_driver = :webkit
  end

  scenario "user can see character countdown when creating a note" do
    sign_in
    visit new_note_path
    page.text.must_include "140 characters remaining"
    fill_in "note_content", with: "MEOW MIX MEOW MIX PLEASE DELIVER!"
    page.text.must_include "107 characters remaining"
  end

  scenario "user can see character countdown when editing a note" do
    sign_in(:lillian)
    visit edit_note_path(notes(:jnote))
    page.text.must_include "118 characters remaining"
    fill_in "note_content", with: "MEOW MIX MEOW MIX PLEASE DELIVER!"
    page.text.must_include "107 characters remaining"
  end
end 