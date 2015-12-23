RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

World(FactoryGirl::Syntax::Methods)
