require "test_helper"

feature "Groups / Creating A Group" do
  scenario "unauthorized site visitor cannot create a group" do
    visit new_group_path
    page.text.must_include "You need to sign in or sign up"
    page.wont_include "Create Group"
  end

  scenario "user can create a group" do
    sign_in(:user)
    visit new_group_path
    fill_in "Name", with: "new group name"
    fill_in "Add Member", with: users(:lillian).email
    click_on "Create Group"

    page.text.must_include "new group name"
    page.text.must_include users(:user).email
    page.text.must_include users(:lillian).email
  end
end
