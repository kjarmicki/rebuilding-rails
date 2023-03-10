require 'sqlite3'
require 'rulers/util'

DB = SQLite3::Database.new 'test.db'

module Rulers
  module Model
    class SQLite
      def initialize(data = nil)
        @hash = data
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def method_missing(method_name, *args, &block)
        method_name = method_name.to_s
        if method_name.end_with?('=')
          return self[method_name[0...-1]] = args[0]
        end
        self[method_name]
      end

      def save!
        unless @hash['id']
          self.class.create(@hash)
          return true
        end

        fields = @hash.map do |k, v|
          "#{k}=#{self.class.to_sql(v)}"
        end.join(',') # calls can be chained after end

        DB.execute <<SQL
UPDATE #{self.class.table}
SET #{fields}
WHERE id = #{@hash['id']}
SQL
        true
      end

      def save
        self.save! rescue false
      end

      def self.to_sql(val)
        case val
        when Numeric
          val.to_s
        when String
          "'#{val}'"
        else
          raise "Can't format #{val.class} to SQL!"
        end
      end

      def self.create(values)
        values.delete 'id'
        keys = schema.keys - ['id']
        vals = keys.map do |key|
          values[key] ? to_sql(values[key]) : 'null'
        end

        DB.execute <<SQL
          INSERT INTO #{table} (#{keys.join(',')})
          VALUES (#{vals.join(',')})
SQL
        data = Hash[keys.zip(vals)]
        sql = 'SELECT last_insert_rowid();'
        data['id'] = DB.execute(sql)[0][0]
        self.new(data)
      end

      def self.count
        # line statements can continue after heredoc initialization:
        DB.execute(<<SQL)[0][0]
          SELECT COUNT(*) FROM #{table}
SQL
      end

      def self.find(id)
        row = DB.execute <<SQL
          SELECT #{schema.keys.join(',')} FROM #{table}
          WHERE id = #{id}
SQL
        data = Hash[schema.keys.zip(row[0])]
        self.new(data)
      end

      def self.table
        Rulers.to_underscore name
      end

      def self.schema
        return @schema if @schema
        @schema = {}
        DB.table_info(table) do |row|
          @schema[row['name']] = row['type']
        end
        @schema
      end
    end
  end
end
