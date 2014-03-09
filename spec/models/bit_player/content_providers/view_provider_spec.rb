require 'spec_helper'

describe BitPlayer::ContentProviders::ViewProvider do
  class S; include BitPlayer::ContentProviders::ViewProvider; end

  describe '.source_class' do
    it 'should raise an exception when no source class has been defined' do
      expect { S.source_class }.to raise_error(RuntimeError)
    end
  end
end
