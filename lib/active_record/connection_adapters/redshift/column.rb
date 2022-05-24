module ActiveRecord
  module ConnectionAdapters
    module Redshift
      class Column < ConnectionAdapters::Column #:nodoc:
        delegate :oid, :fmod, to: :sql_type_metadata

        def initialize(name, default, sql_type_metadata, null = true, table_name = nil, default_function = nil, auto_increment = nil, **)
          super name, default, sql_type_metadata, null, default_function
          @null = null
          @default_function = default_function
          @encoding = nil
          @auto_increment = auto_increment
        end

        def init_with(coder)
          super coder
          @encoding = coder["encoding"]
          @auto_increment = coder["auto_increment"]
        end

        def encode_with(coder)
          super coder
          coder["encoding"] = @encoding
          coder["auto_increment"] = @auto_increment
        end

        def encoding
          @encoding
        end

        def null
          @null
        end

        def auto_increment
          @auto_increment
        end

        def array
          sql_type_metadata.sql_type.end_with?("[]")
        end
        alias :array? :array
      end
    end
    RedshiftColumn = Redshift::Column
  end
end
