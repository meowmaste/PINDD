require "test_helper"

feature "Notes / Checking A Note" do
  scenario "user can click the check box on a note" do
    sign_in(:lillian)
    visit root_path
    box1 = page.find_by_id("check_#{notes(:lnote).id}")
    assert !box1.checked?
    check("check_#{notes(:lnote).id}")

    save_and_open_page

    visit note_path(notes(:lnote))
    box2 = page.find_by_id("check_#{notes(:lnote).id}")
    print page.html
    save_and_open_page

    assert box2.checked?

    ##this test still doesn't work


  end
end
