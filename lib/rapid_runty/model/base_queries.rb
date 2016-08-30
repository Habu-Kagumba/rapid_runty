module RapidRunty
  module Model
    module BaseQueries
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def find(id)
          row = DB.execute_query(
            "SELECT * FROM #{@table} WHERE id = ?",
            id.to_i
          ).first
          model_object(row)
        end

        def find_by(search_params)
          param, value = search_params.first
          row = DB.execute_query(
            "SELECT * FROM #{@table} WHERE #{param} = ?",
            value
          ).first
          model_object(row)
        end

        def first
          row = DB.execute_query(
            "SELECT * FROM #{@table} ORDER BY id LIMIT 1 "
          ).first
          model_object(row)
        end

        def last
          row = DB.execute_query(
            "SELECT * FROM #{@table} ORDER BY id DESC LIMIT 1"
          ).first
          model_object(row)
        end

        def all
          DB.execute_query(
            "SELECT * FROM #{@table} ORDER BY id"
          ).map(&method(:model_object))
        end

        def count
          all.size
        end

        def destroy_all
          DB.execute_query("DELETE from #{@table}")
        end

        def model_object(row)
          return nil unless row
          model ||= new
          @property.keys.each_with_index do |key, index|
            model.send("#{key}=", row[index])
          end
          model
        end
      end

      def save
        if id
          DB.execute_query(
            "UPDATE #{get_table_name} SET #{update_placeholders} WHERE id = ?",
            entity_values << id
          )
        else
          DB.execute_query(
            "INSERT INTO #{get_table_name} (#{get_table_columns}) VALUES (#{new_placeholders})",
            entity_values
          )
        end
        true
      end

      alias save! save

      def destroy
        DB.execute_query("DELETE FROM #{get_table_name} WHERE id = ?", id)
      end

      private

      def get_properties
        self.class.instance_variable_get(:@property)
      end

      def get_table_name
        self.class.instance_variable_get(:@table)
      end

      def entity_values
        get_columns.map(&method(:send))
      end

      def update_placeholders
        get_columns.map { |column| "#{column} = ?" }.join(',')
      end

      def new_placeholders
        (['?'] * (get_properties.keys.size - 1)).join(', ')
      end

      def get_columns
        columns ||= get_properties.keys
        columns.delete(:id)
        columns
      end

      def get_table_columns
        get_columns.map(&:to_s).join(', ')
      end
    end
  end
end
