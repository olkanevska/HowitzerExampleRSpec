module SignUpHelper
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize

  def fill_register_form_with_data(param)
    SignUpPage.on do
      fill_form param
    end
  end
end

RSpec.configure do |config|
  config.include SignUpHelper
end
