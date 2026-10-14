# typed: strong

module OpenAI
  module Models
    module Conversations
      class ComputerScreenshotContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ComputerScreenshotContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The detail level of the screenshot image to be sent to the model. One of `high`,
        # `low`, `auto`, or `original`. Defaults to `auto`.
        sig do
          returns(
            OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
          )
        end
        attr_accessor :detail

        # The identifier of an uploaded file that contains the screenshot.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the screenshot image.
        sig { returns(T.nilable(String)) }
        attr_accessor :image_url

        # Specifies the event type. For a computer screenshot, this property is always set
        # to `computer_screenshot`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig do
          returns(
            T.nilable(
              OpenAI::Conversations::ComputerScreenshotContent::PromptCacheBreakpoint
            )
          )
        end
        attr_reader :prompt_cache_breakpoint

        sig do
          params(
            prompt_cache_breakpoint:
              OpenAI::Conversations::ComputerScreenshotContent::PromptCacheBreakpoint::OrHash
          ).void
        end
        attr_writer :prompt_cache_breakpoint

        # A screenshot of a computer.
        sig do
          params(
            detail:
              OpenAI::Conversations::ComputerScreenshotContent::Detail::OrSymbol,
            file_id: T.nilable(String),
            image_url: T.nilable(String),
            prompt_cache_breakpoint:
              OpenAI::Conversations::ComputerScreenshotContent::PromptCacheBreakpoint::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The detail level of the screenshot image to be sent to the model. One of `high`,
          # `low`, `auto`, or `original`. Defaults to `auto`.
          detail:,
          # The identifier of an uploaded file that contains the screenshot.
          file_id:,
          # The URL of the screenshot image.
          image_url:,
          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          prompt_cache_breakpoint: nil,
          # Specifies the event type. For a computer screenshot, this property is always set
          # to `computer_screenshot`.
          type: :computer_screenshot
        )
        end

        sig do
          override.returns(
            {
              detail:
                OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol,
              file_id: T.nilable(String),
              image_url: T.nilable(String),
              type: Symbol,
              prompt_cache_breakpoint:
                OpenAI::Conversations::ComputerScreenshotContent::PromptCacheBreakpoint
            }
          )
        end
        def to_hash
        end

        # The detail level of the screenshot image to be sent to the model. One of `high`,
        # `low`, `auto`, or `original`. Defaults to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Conversations::ComputerScreenshotContent::Detail
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )
          ORIGINAL =
            T.let(
              :original,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ComputerScreenshotContent::PromptCacheBreakpoint,
                OpenAI::Internal::AnyHash
              )
            end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          sig { params(mode: Symbol).returns(T.attached_class) }
          def self.new(
            # The breakpoint mode. Always `explicit`.
            mode: :explicit
          )
          end

          sig { override.returns({ mode: Symbol }) }
          def to_hash
          end
        end
      end
    end
  end
end
