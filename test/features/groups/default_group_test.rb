require "test_helper"

feature "Groups / Default Group" do
  scenario "user should be in a group of one that cannot be edited or deleted" do
    sign_in(:joslyn)
    visit groups_path
    page.text.must_include groups(:joslyn_default).name ## Might be easier if we delete this from the interface

    visit group_path(groups(:joslyn_default))
    page.wont_have_content "Edit"
    page.wont_have_content "Destroy"
    page.wont_have_content "Delete"
  end
end
