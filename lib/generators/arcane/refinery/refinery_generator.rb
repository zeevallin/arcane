module Arcane
  module Generators
    class RefineryGenerator < ::Rails::Generators::NamedBase

      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_policy
        template 'refinery.rb', File.join('app/refineries', class_path, "#{file_name}_refinery.rb")
      end

    end
  end
end