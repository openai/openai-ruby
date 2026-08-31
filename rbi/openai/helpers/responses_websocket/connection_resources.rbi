# typed: strong

module OpenAI
  module Models
    module Responses
      module ConnectionResources
        class Response
          # @api private
          sig { params(connection: OpenAI::Responses::Connection).returns(T.attached_class) }
          def self.new(connection)
          end

          sig { params(params: T.untyped).void }
          def create(**params)
          end
        end
      end
    end
  end
end
