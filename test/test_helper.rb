ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require "minitest/rails/capybara"

Turn.config.trace = 5
Turn.config.format = :outline
Capybara.javascript_driver = :webkit #for checkbox test

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  fixtures :all

  def sign_in(user = :user)
    visit root_path
    fill_in "Email", with: users(user).email
    fill_in "Password", with: "password"
    click_on "Sign in"
  end

  #for checkbox test
  def trigger_change(jQuerySelector)
    script = "$('#{jQuerySelector}').trigger('change');"
    page.driver.execute_script(script);
  end
end
