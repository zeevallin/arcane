module Arcane
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def copy_application_refinery
        template 'application_refinery.rb', 'app/refineries/application_refinery.rb'
      end

    end
  end
end