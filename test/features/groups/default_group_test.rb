require "test_helper"

feature "Groups / Default Group" do
  scenario "user should be in a group of one that cannot be edited or deleted" do
    sign_in(:joslyn)
    visit groups_path
    page.wont_have_content "-default"

    visit group_path(groups(:joslyn_default))
    page.assert_no_selector("Edit", group_path(groups(:joslyn_default)))
    page.assert_no_selector("Destroy", group_path(groups(:joslyn_default)))
    page.assert_no_selector("Delete", group_path(groups(:joslyn_default)))
  end
end
