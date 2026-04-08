# frozen_string_literal: true

module OpenAI
  module Auth
    module SubjectTokenProvider
      def token_type
        raise NotImplementedError.new("#{self.class} must implement #token_type")
      end

      def get_token
        raise NotImplementedError.new("#{self.class} must implement #get_token")
      end
    end
  end
end
