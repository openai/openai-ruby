# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class AutomationUpdateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationUpdateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :automation_id

          # Only accepted for periodic automations.
          sig { returns(T.nilable(String)) }
          attr_reader :expression

          sig { params(expression: String).void }
          attr_writer :expression

          # Replaces all metadata; omit to leave unchanged.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_reader :metadata

          sig { params(metadata: T::Hash[Symbol, String]).void }
          attr_writer :metadata

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # A future Unix timestamp in seconds; accepted only before a one-time scheduled
          # invocation exists.
          sig { returns(T.nilable(Integer)) }
          attr_reader :run_at

          sig { params(run_at: Integer).void }
          attr_writer :run_at

          # Replaces the complete target, retaining its type and any creator session.
          sig {
            returns(
              T.nilable(
                T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                  OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
                )
              )
            )
          }
          attr_reader :target

          sig {
            params(
              target: T.any(
                OpenAI::Beta::Agents::AutomationTargetParam::NewSession::OrHash,
                OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession::OrHash
              )
            )
              .void
          }
          attr_writer :target

          # Only accepted for periodic automations.
          sig { returns(T.nilable(String)) }
          attr_reader :timezone

          sig { params(timezone: String).void }
          attr_writer :timezone

          sig do
            params(

              automation_id: String,

              expression: String,

              metadata: T::Hash[Symbol, String],

              name: String,

              run_at: Integer,

              target: T.any(
                OpenAI::Beta::Agents::AutomationTargetParam::NewSession::OrHash,
                OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession::OrHash
              ),

              timezone: String,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            automation_id:,

            # Only accepted for periodic automations.
            expression: nil,

            # Replaces all metadata; omit to leave unchanged.
            metadata: nil,

            name: nil,

            # A future Unix timestamp in seconds; accepted only before a one-time scheduled
            # invocation exists.
            run_at: nil,

            # Replaces the complete target, retaining its type and any creator session.
            target: nil,

            # Only accepted for periodic automations.
            timezone: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                automation_id: String,
                expression: String,
                metadata: T::Hash[Symbol, String],
                name: String,
                run_at: Integer,
                target: T.any(
                  OpenAI::Beta::Agents::AutomationTargetParam::NewSession,
                  OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession
                ),
                timezone: String,
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
