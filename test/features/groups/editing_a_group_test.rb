require "test_helper"

feature "Groups / Editing A Group" do
  scenario "unauthorized site visitor cannot edit groups" do
    visit edit_group_path(groups(:jl))
    page.text.must_include "You need to sign in or sign up"
    page.wont_have_content "Update Group"
  end

  scenario "users can add a member to a group she belongs to" do
    sign_in(:joslyn)
    visit edit_group_path(groups(:jl))
    fill_in "Add Member", with: users(:user).email
    click_on "Update Group"
    page.text.must_include users(:joslyn).email
    page.text.must_include users(:lillian).email
    page.text.must_include users(:user).email
  end

  scenario "users can remove a member to a group she belongs to" do
    sign_in(:joslyn)
    visit edit_group_path(groups(:jl))
    select(groups(:lillian).email, :from => 'Remove Box')
    click_on "Update Group"
    page.text.must_include users(:joslyn).email
    page.text.wont_include users(:lillian).email
  end

  scenario "users cannot edit a group she doesn't belong to" do
    sign_in
    visit edit_group_path(groups(:jl))
    page.wont_have_content "Update Group"
  end
end
