module MongoidCart
  class InitializerGenerator < Rails::Generators::Base

    desc "This generator creates an initializer file for MongoidCart"

    def copy_initializer_file
      copy_file "initializer.rb", "config/initializers/#{file_name}.rb"
    end

  end
end