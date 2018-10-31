require 'spec_helper'

RSpec.feature 'Sign Up' do
  given(:user) { build(:user) }

  scenario 'User can open sign up page via menu from home page', smoke: true do
    HomePage.open
    HomePage.on { main_menu_section.choose_menu('Register') }
    expect(SignUpPage).to be_displayed
  end

  scenario 'Visitor can open sign up page via menu from login page' , smoke: true do
    LoginPage.open
    LoginPage.on { navigate_to_link('Sign up') }
    expect(SignUpPage).to be_displayed
  end

  background do
    SignUpPage.open
  end

  scenario 'User can sign up with correct data' , smoke: true do
    fill_register_form_with_data({ user_name: user.name, email: user.email, password: user.password.to_s, password_confirmation: user.password_confirmation.to_s })
    SignUpPage.on { submit_form }
    expect(HomePage).to be_displayed
    HomePage.on do
      is_expected.to have_main_menu_section
      expect(main_menu_section).to be_authenticated(out(:user).name)
    end
  end

  scenario 'User can not sign up with blank data', p1: true do
    fill_register_form_with_data({})
    SignUpPage.on do
      submit_form
      expect(text).to include('Please review the problems below')
    end
  end

  scenario 'User can not sign up with too short password', p1: true do
    fill_register_form_with_data({ user_name: user.name, email: user.email, password: user.password.to_s[0..5], password_confirmation: user.password_confirmation.to_s[0..5]})
    SignUpPage.on do
      submit_form
      expect(text).to include('is too short (minimum is 8 characters)')
    end
    HomePage.open
    HomePage.on do
      is_expected.to have_main_menu_section
      expect(main_menu_section).to be_not_authenticated
    end
  end

  scenario 'User can not login with different password data', p1: true do
    fill_register_form_with_data({ user_name: user.name, email: user.email, password: user.password.to_s, password_confirmation: user.password_confirmation.to_s.concat(33)})
    SignUpPage.on do
      submit_form
      expect(text).to include( "doesn't match Password")
    end
    HomePage.open
    HomePage.on do
      is_expected.to have_main_menu_section
      expect(main_menu_section).to be_not_authenticated
    end
  end
 end
