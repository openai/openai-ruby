# typed: strong

module OpenAI
  module Resources
    class Realtime
      class Translations
        class Calls
          sig do
            params(
              sdp: String,
              request_options: T.nilable(OpenAI::RequestOptions::OrHash)
            ).returns(OpenAI::Realtime::CallCreateResponse)
          end
          def create(sdp:, request_options: nil)
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
