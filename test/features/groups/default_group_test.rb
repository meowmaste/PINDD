require "test_helper"

feature "Groups / Default Group" do
  scenario "user should be in a group of one that cannot be edited or deleted" do
    sign_in(:joslyn)
    visit groups_path
    page.wont_have_content "-default"

    visit group_path(groups(:joslyn_default))
    save_and_open_page
    page.wont_have_content "Edit"
    page.wont_have_content "Destroy"
    page.wont_have_content "Delete"
  end
end
