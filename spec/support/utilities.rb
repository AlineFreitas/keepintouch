include ApplicationHelper

def valid_signin(collaborator)
  fill_in "Email",    with: collaborator.email
  fill_in "Password", with: collaborator.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end
