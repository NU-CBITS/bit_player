require "active_support/concern"

module BitPlayer
  module ContentProviders
    # Presentation logic for a "show" or "index" view on a data model.
    module ViewProvider
      extend ActiveSupport::Concern

      included do
        def self.data_class(klass)
          @source_class = klass
        end

        def self.source_class
          @source_class || raise("Classes inheriting from #{self} must " \
                                 "define a source class with " \
                                 "`data_class <class>`")
        end

        def self.show_nav_link
          @show_nav_link = true
        end

        def self.hide_nav_link
          @show_nav_link = false
        end

        def self.show_nav_link?
          @show_nav_link
        end

        def self.view_type(type)
          unless %w( show index ).include?(type)
            raise "view type must be one of 'show', 'index'"
          end
          @view_type = type
        end

        def self.get_view_type
          @view_type
        end
      end

      def show_nav_link?
        self.class.show_nav_link?
      end

      def template
        "#{plural_name}/#{self.class.get_view_type}"
      end

      private

      def plural_name
        self.class.source_class.to_s.underscore.pluralize
      end
    end
  end
end
