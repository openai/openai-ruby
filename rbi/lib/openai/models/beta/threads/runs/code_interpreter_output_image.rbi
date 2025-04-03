# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterOutputImage < OpenAI::BaseModel
            # The index of the output in the outputs array.
            sig { returns(Integer) }
            attr_accessor :index

            # Always `image`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image)) }
            attr_reader :image

            sig do
              params(
                image: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image,
                  OpenAI::Internal::Util::AnyHash
                )
              )
                .void
            end
            attr_writer :image

            sig do
              params(
                index: Integer,
                image: T.any(
                  OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image,
                  OpenAI::Internal::Util::AnyHash
                ),
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(index:, image: nil, type: :image)
            end

            sig do
              override
                .returns(
                  {index: Integer, type: Symbol, image: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image}
                )
            end
            def to_hash
            end

            class Image < OpenAI::BaseModel
              # The [file](https://platform.openai.com/docs/api-reference/files) ID of the
              #   image.
              sig { returns(T.nilable(String)) }
              attr_reader :file_id

              sig { params(file_id: String).void }
              attr_writer :file_id

              sig { params(file_id: String).returns(T.attached_class) }
              def self.new(file_id: nil)
              end

              sig { override.returns({file_id: String}) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
