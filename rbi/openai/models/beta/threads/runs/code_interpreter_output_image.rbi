# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterOutputImage < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage,
                  OpenAI::Internal::AnyHash
                )
              end

            # The index of the output in the outputs array.
            sig { returns(Integer) }
            attr_accessor :index

            # Always `image`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::Image
                )
              )
            end
            attr_reader :image

            sig do
              params(
                image:
                  OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::Image::OrHash
              ).void
            end
            attr_writer :image

            sig do
              params(
                index: Integer,
                image:
                  OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::Image::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The index of the output in the outputs array.
              index:,
              image: nil,
              # Always `image`.
              type: :image
            )
            end

            sig do
              override.returns(
                {
                  index: Integer,
                  type: Symbol,
                  image:
                    OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::Image
                }
              )
            end
            def to_hash
            end

            class Image < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::CodeInterpreterOutputImage::Image,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The [file](https://platform.openai.com/docs/api-reference/files) ID of the
              # image.
              sig { returns(T.nilable(String)) }
              attr_reader :file_id

              sig { params(file_id: String).void }
              attr_writer :file_id

              sig { params(file_id: String).returns(T.attached_class) }
              def self.new(
                # The [file](https://platform.openai.com/docs/api-reference/files) ID of the
                # image.
                file_id: nil
              )
              end

              sig { override.returns({ file_id: String }) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
