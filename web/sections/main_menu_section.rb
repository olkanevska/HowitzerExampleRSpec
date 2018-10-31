class MainMenuSection < Howitzer::Web::Section
  me '.container.initialized'

  element :account, :xpath, ->(value) { "//a[contains(text(),'#{value}')]" }
  element :menu_item, :xpath, ->(name) { "//a[.='#{name}']" }

  def authenticated?(user)
    has_account_element?(user)
  end

  def not_authenticated?(text = 'Login')
    has_menu_item_element?(text)
  end

  def choose_menu(text)
    Howitzer::Log.info "Open '#{text}' menu"
    menu_item_element(text).click
  end
end
