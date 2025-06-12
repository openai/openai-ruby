# typed: strong

module OpenAI
  module Resources
    class Containers
      class Files
        sig { returns(OpenAI::Resources::Containers::Files::Content) }
        attr_reader :content

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
