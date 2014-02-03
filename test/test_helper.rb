ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require "minitest/rails/capybara"

Turn.config.trace = 3
Turn.config.format = :outline

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  fixtures :all

  def sign_in
    visit root_path
    fill_in "Email", with: users(:lillian).email
    fill_in "Password", with: "password"
    click_on "Sign in"
  end
end
