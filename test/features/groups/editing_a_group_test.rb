require "test_helper"

feature "Groups / Editing A Group" do
  scenario "unauthorized site visitor cannot edit groups" do
    visit edit_group_path(groups(:joslyn_lillian))
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content "Update Group"
  end

  scenario "users can add a member to a group she belongs to" do
    sign_in(:joslyn)
    visit edit_group_path(groups(:joslyn_lillian))
    fill_in "group_add_member", with: users(:user).email
    click_on "Update Group"
    within (".show-group") do
      page.text.must_include users(:joslyn).email
      page.text.must_include users(:lillian).email
      page.text.must_include users(:user).email
    end
    page.text.must_include "was added to group"
  end

  scenario "users can remove a member to a group she belongs to" do
    sign_in(:joslyn)
    visit edit_group_path(groups(:joslyn_lillian))
    select(users(:lillian).email, :from => 'Remove member')
    click_on "Update Group"
    within (".show-group") do
      page.text.must_include users(:joslyn).email
      page.text.wont_include users(:lillian).email
    end
    page.text.must_include "was removed from group"
  end

  scenario "users cannot edit a group she doesn't belong to" do
    sign_in
    visit edit_group_path(groups(:joslyn_lillian))
    page.wont_have_content "Update Group"
  end

  scenario "users cannot remove last member from group" do
    sign_in(:joslyn)
    visit edit_group_path(groups(:joslyn_lillian))
    select(users(:lillian).email, :from => 'Remove member')
    click_on "Update Group"
    visit edit_group_path(groups(:joslyn_lillian))
    page.wont_have_content "Remove member"
    page.wont_have_field "group_remove_member"
  end
end
