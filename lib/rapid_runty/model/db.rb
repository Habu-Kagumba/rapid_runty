require 'sqlite3'

module RapidRunty
  module Model
    class DB
      def self.create_db
        SQLite3::Database.new(File.join(ROOT_DIR, 'db', 'rapid.db'))
      end

      def self.execute_query(*query)
        @db ||= create_db
        @db.execute(*query)
      end
    end
  end
end
