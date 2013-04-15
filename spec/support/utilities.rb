include ApplicationHelper

def valid_user
  fill_in "Name", with: "Example User"
  fill_in "Email", with: "user@example.com"
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_header do |header|
  match do |page|
    page.should have_selector('h1', text: header)
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_no_error_message do
  match do |page|
    page.should have_no_selector('div.alert.alert-error')
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_no_success_message do
  match do |page|
    page.should have_no_selector('div.alert.alert-success')
  end
end

RSpec::Matchers.define :have_title do |title|
  match do |page|
    page.find('title').native.text.should == title
  end
end
