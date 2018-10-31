class HomePage < Howitzer::Web::Page
  path '/'
  validate :title, /\AYour advanced automated testing service provider | StrongQA\z/
  section :main_menu
end
