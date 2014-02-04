require "test_helper"

feature "Groups / Showing A Group" do
  scenario "unauthorized site visitor cannot see a group" do
    visit groups_path
    page.text.must_include "You need to sign in or sign up"
    page.text.wont_include groups(:joslyn_lillian).name

    visit group_path(groups(:joslyn_lillian))
    page.text.must_include "You need to sign in or sign up"
    page.text.wont_include groups(:joslyn_lillian).name
  end

  scenario "user can see members in groups she belongs to" do
    sign_in(:joslyn)
    visit groups_path
    page.text.must_include groups(:joslyn_lillian).name

    visit group_path(groups(:joslyn_lillian))
    page.text.must_include groups(:joslyn_lillian).name
    page.text.must_include users(:joslyn).email
    page.text.must_include users(:lillian).email
    page.text.wont_include users(:user).email
  end
end
