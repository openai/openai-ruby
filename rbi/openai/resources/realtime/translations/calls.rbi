# typed: strong

module OpenAI
  module Resources
    class Realtime
      class Translations
        class Calls
          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
