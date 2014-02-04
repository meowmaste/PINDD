require "test_helper"

feature "Groups / Deleting A Group" do
  scenario "unauthorized site user cannot delete a group" do
    visit groups_path
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content "Destroy"
  end

  scenario "users can delete a groups where she is a member" do
    sign_in(:joslyn)
    visit groups_path
    page.find("a[href='#{group_path(groups(:joslyn_lillian))}'][data-method='delete']").click
    page.text.must_include groups(:joslyn_default).name
    page.text.wont_include groups(:joslyn_lillian).name
  end

  scenario "users cannot delete a group where she is not a member" do
    sign_in
    visit groups_path
    page.find("a[href='#{group_path(groups(:joslyn_lillian))}'][data-method='delete']").click
    click_on "logout"

    sign_in(:joslyn)
    visit groups_path
    page.text.must_include groups(:joslyn_lillian).name
  end
end
