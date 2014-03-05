require "test_helper"

feature "Notes / Checking A Note" do
  scenario "user clicking the check box on a note saves to database" do
    sign_in(:lillian)
    visit root_path
    assert !notes(:lnote).check, "Test started checked"
    check("check_#{notes(:lnote).id}")
    # trigger_change("check_#{notes(:lnote).id}")
    visit note_path(notes(:lnote))
    # puts notes(:lnote).check
    assert notes(:lnote).check, "Check does not update database"

    #this test is still failing because the capybara is not causing a change event on the checkbox

  end
end
