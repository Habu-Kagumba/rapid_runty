require 'rapid_runty/model/db'
require 'rapid_runty/model/base_queries'

module RapidRunty
  module Model
    class Base
      include RapidRunty::Model::BaseQueries

      def self.to_table(name)
        @table = name.to_s
      end

      def self.property(field, attr)
        @property ||= {}
        @property[field] = attr
      end

      def self.create_table
        DB.execute_query(
          "CREATE TABLE IF NOT EXISTS #{@table}" \
          "(#{column_names.join(', ')})"
        )
        @property.keys.each(&method(:attr_accessor))
      end

      def self.primary_key(primary)
        'PRIMARY KEY AUTOINCREMENT' if primary
      end

      def self.nullable(is_null)
        'NOT NULL' unless is_null
      end

      def self.type(value)
        value.to_s
      end

      def self.column_names
        columns = []
        @property.each do |column_name, constraints|
          properties_and_constraints = []
          properties_and_constraints << column_name.to_s
          constraints.each do |attribute, value|
            properties_and_constraints << send(attribute.downcase.to_s, value)
          end
          columns << properties_and_constraints.join(' ')
        end
        columns
      end
    end
  end
end
