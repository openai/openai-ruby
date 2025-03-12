# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContentPartAddedEvent < OpenAI::BaseModel
        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        sig do
          returns(
            T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
          )
        end
        def part
        end

        sig do
          params(
            _: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
          )
            .returns(
              T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)
            )
        end
        def part=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            part: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content_index:, item_id:, output_index:, part:, type: :"response.content_part.added")
        end

        sig do
          override
            .returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                part: T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal),
                type: Symbol
              }
            )
        end
        def to_hash
        end

        class Part < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Responses::ResponseOutputText], [Symbol, OpenAI::Models::Responses::ResponseOutputRefusal]]
                )
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
