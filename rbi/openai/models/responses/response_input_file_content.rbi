# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputFileContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputFileContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the input item. Always `input_file`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The detail level of the file to be sent to the model. Use `auto` to let the
        # system select the detail level; for GPT-5.6 and later models, `auto` uses
        # high-quality rendering, which may increase input token usage. Use `low` for
        # lower-cost rendering, or `high` to render the file at higher quality. Defaults
        # to `auto`.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseInputFileContent::Detail::OrSymbol
            )
          )
        end
        attr_reader :detail

        sig do
          params(
            detail:
              OpenAI::Responses::ResponseInputFileContent::Detail::OrSymbol
          ).void
        end
        attr_writer :detail

        # The base64-encoded data of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_data

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_url

        # The name of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :filename

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseInputFileContent::PromptCacheBreakpoint
            )
          )
        end
        attr_reader :prompt_cache_breakpoint

        sig do
          params(
            prompt_cache_breakpoint:
              T.nilable(
                OpenAI::Responses::ResponseInputFileContent::PromptCacheBreakpoint::OrHash
              )
          ).void
        end
        attr_writer :prompt_cache_breakpoint

        # A file input to the model.
        sig do
          params(
            detail:
              OpenAI::Responses::ResponseInputFileContent::Detail::OrSymbol,
            file_data: T.nilable(String),
            file_id: T.nilable(String),
            file_url: T.nilable(String),
            filename: T.nilable(String),
            prompt_cache_breakpoint:
              T.nilable(
                OpenAI::Responses::ResponseInputFileContent::PromptCacheBreakpoint::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The detail level of the file to be sent to the model. Use `auto` to let the
          # system select the detail level; for GPT-5.6 and later models, `auto` uses
          # high-quality rendering, which may increase input token usage. Use `low` for
          # lower-cost rendering, or `high` to render the file at higher quality. Defaults
          # to `auto`.
          detail: nil,
          # The base64-encoded data of the file to be sent to the model.
          file_data: nil,
          # The ID of the file to be sent to the model.
          file_id: nil,
          # The URL of the file to be sent to the model.
          file_url: nil,
          # The name of the file to be sent to the model.
          filename: nil,
          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          prompt_cache_breakpoint: nil,
          # The type of the input item. Always `input_file`.
          type: :input_file
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              detail:
                OpenAI::Responses::ResponseInputFileContent::Detail::OrSymbol,
              file_data: T.nilable(String),
              file_id: T.nilable(String),
              file_url: T.nilable(String),
              filename: T.nilable(String),
              prompt_cache_breakpoint:
                T.nilable(
                  OpenAI::Responses::ResponseInputFileContent::PromptCacheBreakpoint
                )
            }
          )
        end
        def to_hash
        end

        # The detail level of the file to be sent to the model. Use `auto` to let the
        # system select the detail level; for GPT-5.6 and later models, `auto` uses
        # high-quality rendering, which may increase input token usage. Use `low` for
        # lower-cost rendering, or `high` to render the file at higher quality. Defaults
        # to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseInputFileContent::Detail)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ResponseInputFileContent::Detail::TaggedSymbol
            )
          LOW =
            T.let(
              :low,
              OpenAI::Responses::ResponseInputFileContent::Detail::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Responses::ResponseInputFileContent::Detail::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputFileContent::Detail::TaggedSymbol
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
                OpenAI::Responses::ResponseInputFileContent::PromptCacheBreakpoint,
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
