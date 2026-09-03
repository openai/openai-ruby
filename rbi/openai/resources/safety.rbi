# typed: strong

module OpenAI
  module Resources

    class Safety

      sig { returns(OpenAI::Resources::Safety::Alerts) }
      attr_reader :alerts

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end

  end
end
