# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseInputImage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseInputImage,
            OpenAI::Internal::AnyHash
          )
        end

        # The detail level of the image to be sent to the model. One of `high`, `low`,
        # `auto`, or `original`. Defaults to `auto`.
        sig { returns(OpenAI::Responses::ResponseInputImage::Detail::OrSymbol) }
        attr_accessor :detail

        # The type of the input item. Always `input_image`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the image to be sent to the model. A fully qualified URL or base64
        # encoded image in a data URL.
        sig { returns(T.nilable(String)) }
        attr_accessor :image_url

        # Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
        # breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
        # not rounded to a token block.
        sig { returns(T.nilable(OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint)) }
        attr_reader :prompt_cache_breakpoint

        sig {
          params(prompt_cache_breakpoint: OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::OrHash).void
        }
        attr_writer :prompt_cache_breakpoint

        # An image input to the model. Learn about
        # [image inputs](https://developers.openai.com/api/docs/guides/images-vision).
        sig do
          params(

            detail: OpenAI::Responses::ResponseInputImage::Detail::OrSymbol,

            file_id: T.nilable(String),

            image_url: T.nilable(String),

            prompt_cache_breakpoint: OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The detail level of the image to be sent to the model. One of `high`, `low`,
          # `auto`, or `original`. Defaults to `auto`.
          detail:,

          # The ID of the file to be sent to the model.
          file_id: nil,

          # The URL of the image to be sent to the model. A fully qualified URL or base64
          # encoded image in a data URL.
          image_url: nil,

          # Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
          # breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
          # not rounded to a token block.
          prompt_cache_breakpoint: nil,

          # The type of the input item. Always `input_image`.

          type: :input_image
        )
        end

        sig do
          override.returns(
            {
              detail: OpenAI::Responses::ResponseInputImage::Detail::OrSymbol,
              type: Symbol,
              file_id: T.nilable(String),
              image_url: T.nilable(String),
              prompt_cache_breakpoint: OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        # The detail level of the image to be sent to the model. One of `high`, `low`,
        # `auto`, or `original`. Defaults to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseInputImage::Detail) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW = T.let(:low, OpenAI::Responses::ResponseInputImage::Detail::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::Responses::ResponseInputImage::Detail::TaggedSymbol)
          AUTO = T.let(:auto, OpenAI::Responses::ResponseInputImage::Detail::TaggedSymbol)
          ORIGINAL = T.let(:original, OpenAI::Responses::ResponseInputImage::Detail::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Responses::ResponseInputImage::Detail::TaggedSymbol]) }
          def self.values
          end
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint,
              OpenAI::Internal::AnyHash
            )
          end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          sig { returns(T.nilable(OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::OrSymbol)) }
          attr_reader :ttl

          sig { params(ttl: OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::OrSymbol).void }
          attr_writer :ttl

          # Marks the exact end of a reusable prompt prefix. When `ttl` is omitted, the
          # breakpoint inherits the request's `prompt_cache_options.ttl`; the boundary is
          # not rounded to a token block.
          sig do
            params(

              ttl: OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::OrSymbol,

              mode: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
            ttl: nil,

            # The breakpoint mode. Always `explicit`.

            mode: :explicit
          )
          end

          sig do
            override.returns(
              {mode: Symbol, ttl: OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::OrSymbol}
            )
          end
          def to_hash
          end

          # The minimum lifetime of this cache breakpoint. Defaults to the request TTL.
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TTL_30M = T.let(:"30m", OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::TaggedSymbol)
            TTL_12H = T.let(:"12h", OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::TaggedSymbol)

            sig {
              override.returns(
                T::Array[OpenAI::Responses::ResponseInputImage::PromptCacheBreakpoint::Ttl::TaggedSymbol]
              )
            }
            def self.values
            end
          end
        end

      end

    end

  end
end
