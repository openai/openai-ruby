# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::RunUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :thread_id

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          sig do
            params(
              thread_id: String,
              metadata: T.nilable(T::Hash[Symbol, String]),
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            thread_id:,
            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                thread_id: String,
                metadata: T.nilable(T::Hash[Symbol, String]),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
