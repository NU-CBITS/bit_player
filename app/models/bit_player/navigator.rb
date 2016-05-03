require "bit_core"

module BitPlayer
  # Business rules for proceeding statefully through an application.
  class Navigator
    RenderOptions = Struct.new(
      :view_context, :app_context, :position, :participant
    )

    def initialize(participant)
      @participant = participant
      @status = participant.navigation_status
    end

    def context
      @status.context
    end

    def module_position
      @status.module_position
    end

    def provider_position
      @status.provider_position
    end

    def content_position
      @status.content_position
    end

    def render_current_content(view_context)
      options = RenderOptions.new(
        view_context, context, content_position, @participant
      )

      current_content_provider.render_current(options)
    end

    def show_nav_link?
      current_content_provider.show_nav_link?
    end

    def current_content_provider
      current_module.provider(provider_position)
    end

    def fetch_next_content
      if content_position &&
         current_content_provider.exists?(content_position + 1)
        @status.increment_content_position
      elsif provider_position &&
            current_module.provider_exists?(provider_position + 1)
        @status.increment_provider_position
      else
        initialize_context(context)
      end
    end

    def fetch_previous_content
      return unless previous_content?

      @status.decrement_content_position
    end

    def previous_content?
      current_content_provider.exists?(content_position - 1)
    end

    def initialize_context(context)
      @status.initialize_context(context)
    end

    def initialize_location(options)
      content_module = BitCore::ContentModule.find(options[:module_id])
      @status.context = content_module.tool.title
      @status.module_position = content_module.position
      @status.provider_position = 1
      if options[:provider_id]
        @status.provider_position = content_module.content_providers
                                                  .find(options[:provider_id])
                                                  .position
      end
      @status.content_position = [options[:content_position].to_i, 1].max
      @status.save
    end

    def current_module
      @current_module ||= nil
      arm = @participant.active_group.arm

      module_attrs = {
        bit_core_tool_id: arm.bit_core_tools.find_by_title(context).try(:id),
        position: module_position
      }

      if current_module_stale?
        @current_module = BitCore::ContentModule.where(module_attrs).first
      end

      @current_module ||= BitCore::ContentModule.new(module_attrs)
    end

    private

    def current_module_stale?
      @current_module.nil? ||
        (@current_module.tool.try(:title) != context ||
         @current_module.position != module_position)
    end
  end
end
