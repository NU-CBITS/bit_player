module BitPlayer
  # Persistent data representing the Participant's navigation state.
  class ParticipantStatus < ActiveRecord::Base
    belongs_to :participant

    def initialize_context(name)
      update(
        context: name,
        module_position: 1,
        provider_position: 1,
        content_position: 1
      )
    end

    def decrement_content_position
      update(content_position: content_position - 1)
    end

    def increment_content_position
      update(content_position: content_position + 1)
    end

    def increment_provider_position
      update(
        provider_position: provider_position + 1,
        content_position: 1
      )
    end
  end
end
