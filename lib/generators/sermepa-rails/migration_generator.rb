require 'rails/generators/migration'

module Sermepa
  module Rails

    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Created the migration for the Sermepa Response model"

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def copy_translations_migration
        migration_template "migration.rb", "db/migrate/sermepa_create_responses.rb"
      end

    end
  end
end


