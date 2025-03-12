# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterOutputImage < OpenAI::BaseModel
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image)) }
            def image
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image)
                .returns(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image)
            end
            def image=(_)
            end

            sig do
              params(
                index: Integer,
                image: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage::Image,
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
              sig { returns(T.nilable(String)) }
              def file_id
              end

              sig { params(_: String).returns(String) }
              def file_id=(_)
              end

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
