module BitPlayer
  class ContentModule < ActiveRecord::Base
    validates :title, :context, :position, presence: true
    validates_numericality_of :position, greater_than_or_equal_to: 1
    validates_uniqueness_of :position, scope: :context

    def providers
      ContentProvider.where(bit_player_content_module_id: id).order(:position)
    end

    def provider(position)
      providers.where(position: position).first ||
        BitPlayer::ContentProviders::Null.new(self)
    end

    def provider_exists?(position)
      providers.exists?(position: position)
    end
  end
end
