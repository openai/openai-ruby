# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class SessionUpdateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::SessionUpdateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :session_id

          # Model settings for subsequent turns. Omitted fields stay unchanged.
          sig { returns(T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent)) }
          attr_reader :agent

          sig { params(agent: OpenAI::Beta::Agents::SessionUpdateParams::Agent::OrHash).void }
          attr_writer :agent

          # Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
          # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
          # characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          sig do
            params(

              session_id: String,

              agent: OpenAI::Beta::Agents::SessionUpdateParams::Agent::OrHash,

              metadata: T.nilable(T::Hash[Symbol, String]),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            session_id:,

            # Model settings for subsequent turns. Omitted fields stay unchanged.
            agent: nil,

            # Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
            # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            # characters.
            metadata: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                session_id: String,
                agent: OpenAI::Beta::Agents::SessionUpdateParams::Agent,
                metadata: T.nilable(T::Hash[Symbol, String]),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::SessionUpdateParams::Agent,
                OpenAI::Internal::AnyHash
              )
            end

            # The model for subsequent turns. Omit to keep the current model.
            sig { returns(T.nilable(String)) }
            attr_reader :model

            sig { params(model: String).void }
            attr_writer :model

            # Reasoning settings to update. Omit to keep the current effort.
            sig { returns(T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning)) }
            attr_reader :reasoning

            sig { params(reasoning: OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::OrHash).void }
            attr_writer :reasoning

            # Omit to keep the current tier. Null resets it to auto.
            sig { returns(T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::OrSymbol)) }
            attr_accessor :service_tier

            # Model settings for subsequent turns. Omitted fields stay unchanged.
            sig do
              params(

                model: String,

                reasoning: OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::OrHash,

                service_tier: T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::OrSymbol)
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The model for subsequent turns. Omit to keep the current model.
              model: nil,

              # Reasoning settings to update. Omit to keep the current effort.
              reasoning: nil,

              # Omit to keep the current tier. Null resets it to auto.

              service_tier: nil
            )
            end

            sig do
              override.returns(
                {
                  model: String,
                  reasoning: OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning,
                  service_tier: T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::OrSymbol)
                }
              )
            end
            def to_hash
            end

            class Reasoning < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning,
                  OpenAI::Internal::AnyHash
                )
              end

              # Omit to keep the current effort. Null selects the model's default effort.
              sig { returns(T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::OrSymbol)) }
              attr_accessor :effort

              # Reasoning settings to update. Omit to keep the current effort.
              sig do
                params(

                  effort: T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::OrSymbol)
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Omit to keep the current effort. Null selects the model's default effort.

                effort: nil
              )
              end

              sig do
                override.returns(
                  {effort: T.nilable(OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::OrSymbol)}
                )
              end
              def to_hash
              end

              # Omit to keep the current effort. Null selects the model's default effort.
              module Effort
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                NONE = T.let(:none, OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol)
                MINIMAL = T.let(
                  :minimal,
                  OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol
                )
                LOW = T.let(:low, OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol)
                MEDIUM = T.let(
                  :medium,
                  OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol
                )
                HIGH = T.let(:high, OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol)
                XHIGH = T.let(:xhigh, OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol)
                MAX = T.let(:max, OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol)

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::SessionUpdateParams::Agent::Reasoning::Effort::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            # Omit to keep the current tier. Null resets it to auto.
            module ServiceTier
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Selects the service tier automatically.
              AUTO = T.let(:auto, OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the default service tier.
              DEFAULT = T.let(:default, OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the flex service tier.
              FLEX = T.let(:flex, OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the priority service tier.
              PRIORITY = T.let(:priority, OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::TaggedSymbol)

              # Uses the fast service tier.
              FAST = T.let(:fast, OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::TaggedSymbol)

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::SessionUpdateParams::Agent::ServiceTier::TaggedSymbol])
              }
              def self.values
              end
            end
          end

        end

      end

    end

  end
end
