# typed: strong

module OpenAI
  module Models
    module Responses
      class ContainerAuto < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ContainerAuto, OpenAI::Internal::AnyHash)
          end

        # Automatically creates a container for this request
        sig { returns(Symbol) }
        attr_accessor :type

        # An optional list of uploaded files to make available to your code.
        sig { returns(T.nilable(T::Array[String])) }
        attr_reader :file_ids

        sig { params(file_ids: T::Array[String]).void }
        attr_writer :file_ids

        # The memory limit for the container.
        sig do
          returns(
            T.nilable(OpenAI::Responses::ContainerAuto::MemoryLimit::OrSymbol)
          )
        end
        attr_accessor :memory_limit

        # Network access policy for the container.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ContainerNetworkPolicyDisabled,
                OpenAI::Responses::ContainerNetworkPolicyAllowlist
              )
            )
          )
        end
        attr_reader :network_policy

        sig do
          params(
            network_policy:
              T.any(
                OpenAI::Responses::ContainerNetworkPolicyDisabled::OrHash,
                OpenAI::Responses::ContainerNetworkPolicyAllowlist::OrHash
              )
          ).void
        end
        attr_writer :network_policy

        # An optional list of skills referenced by id or inline data.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Responses::SkillReference,
                  OpenAI::Responses::InlineSkill
                )
              ]
            )
          )
        end
        attr_reader :skills

        sig do
          params(
            skills:
              T::Array[
                T.any(
                  OpenAI::Responses::SkillReference::OrHash,
                  OpenAI::Responses::InlineSkill::OrHash
                )
              ]
          ).void
        end
        attr_writer :skills

        sig do
          params(
            file_ids: T::Array[String],
            memory_limit:
              T.nilable(
                OpenAI::Responses::ContainerAuto::MemoryLimit::OrSymbol
              ),
            network_policy:
              T.any(
                OpenAI::Responses::ContainerNetworkPolicyDisabled::OrHash,
                OpenAI::Responses::ContainerNetworkPolicyAllowlist::OrHash
              ),
            skills:
              T::Array[
                T.any(
                  OpenAI::Responses::SkillReference::OrHash,
                  OpenAI::Responses::InlineSkill::OrHash
                )
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # An optional list of uploaded files to make available to your code.
          file_ids: nil,
          # The memory limit for the container.
          memory_limit: nil,
          # Network access policy for the container.
          network_policy: nil,
          # An optional list of skills referenced by id or inline data.
          skills: nil,
          # Automatically creates a container for this request
          type: :container_auto
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              file_ids: T::Array[String],
              memory_limit:
                T.nilable(
                  OpenAI::Responses::ContainerAuto::MemoryLimit::OrSymbol
                ),
              network_policy:
                T.any(
                  OpenAI::Responses::ContainerNetworkPolicyDisabled,
                  OpenAI::Responses::ContainerNetworkPolicyAllowlist
                ),
              skills:
                T::Array[
                  T.any(
                    OpenAI::Responses::SkillReference,
                    OpenAI::Responses::InlineSkill
                  )
                ]
            }
          )
        end
        def to_hash
        end

        # The memory limit for the container.
        module MemoryLimit
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ContainerAuto::MemoryLimit)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MEMORY_LIMIT_1G =
            T.let(
              :"1g",
              OpenAI::Responses::ContainerAuto::MemoryLimit::TaggedSymbol
            )
          MEMORY_LIMIT_4G =
            T.let(
              :"4g",
              OpenAI::Responses::ContainerAuto::MemoryLimit::TaggedSymbol
            )
          MEMORY_LIMIT_16G =
            T.let(
              :"16g",
              OpenAI::Responses::ContainerAuto::MemoryLimit::TaggedSymbol
            )
          MEMORY_LIMIT_64G =
            T.let(
              :"64g",
              OpenAI::Responses::ContainerAuto::MemoryLimit::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ContainerAuto::MemoryLimit::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # Network access policy for the container.
        module NetworkPolicy
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ContainerNetworkPolicyDisabled,
                OpenAI::Responses::ContainerNetworkPolicyAllowlist
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ContainerAuto::NetworkPolicy::Variants
              ]
            )
          end
          def self.variants
          end
        end

        module Skill
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::SkillReference,
                OpenAI::Responses::InlineSkill
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ContainerAuto::Skill::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
