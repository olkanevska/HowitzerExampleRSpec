class SignUpPage < Howitzer::Web::Page
  path '/users/sign-up'
  validate :title, /\ARegister account for StrongQA | StrongQA\z/
  section :main_menu

  element :user_name_input, '#user_full_name'
  element :email_input, '#user_email'
  element :password_input, '#user_password'
  element :password_confirmation_input, '#user_password_confirmation'
  element :sign_up_btn, :button, 'Register'

  def fill_form(user_data_hash)
    Howitzer::Log.info 'Fill in Register Form with data:' \
               "#{user_data_hash}"
    user_name_input_element.set(user_data_hash[:user_name])
    email_input_element.set(user_data_hash[:email])
    password_input_element.set(user_data_hash[:password])
    password_confirmation_input_element.set(user_data_hash[:password_confirmation])
  end

  def submit_form
    Howitzer::Log.info 'Submit Register Form'
    sign_up_btn_element.click
  end
end
