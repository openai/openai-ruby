# typed: strong

module OpenAI
  module Resources

    class Safety

      class Cases

        # Get a safety case by ID.
        sig { params(id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Safety::SafetyCase) }
        def retrieve(
          # Safety case ID
          id,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
