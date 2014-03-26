module BitPlayer
  module ContentProviders
    # The default provider.
    class Null
      def initialize(content_module)
        @content_module = content_module
      end

      def render_current(options)
        "Content Module #{ @content_module.title }: Oops, did you expect a
        content provider here?"
      end

      def show_nav_link?
        true
      end
    end
  end
end
