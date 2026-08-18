# typed: strong

module OpenAI
  module Models

    class ContainerCreateParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::ContainerCreateParams,
          OpenAI::Internal::AnyHash
        )
      end

      # Name of the container to create.
      sig { returns(String) }
      attr_accessor :name

      # Container expiration time in seconds relative to the 'anchor' time.
      sig { returns(T.nilable(OpenAI::ContainerCreateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig { params(expires_after: OpenAI::ContainerCreateParams::ExpiresAfter::OrHash).void }
      attr_writer :expires_after

      # IDs of files to copy to the container.
      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :file_ids

      sig { params(file_ids: T::Array[String]).void }
      attr_writer :file_ids

      # Optional memory limit for the container. Defaults to "1g".
      sig { returns(T.nilable(OpenAI::ContainerCreateParams::MemoryLimit::OrSymbol)) }
      attr_reader :memory_limit

      sig { params(memory_limit: OpenAI::ContainerCreateParams::MemoryLimit::OrSymbol).void }
      attr_writer :memory_limit

      # Network access policy for the container.
      sig {
        returns(
          T.nilable(
            T.any(OpenAI::Responses::ContainerNetworkPolicyDisabled, OpenAI::Responses::ContainerNetworkPolicyAllowlist)
          )
        )
      }
      attr_reader :network_policy

      sig {
        params(
          network_policy: T.any(
            OpenAI::Responses::ContainerNetworkPolicyDisabled::OrHash,
            OpenAI::Responses::ContainerNetworkPolicyAllowlist::OrHash
          )
        )
          .void
      }
      attr_writer :network_policy

      # An optional list of skills referenced by id or inline data.
      sig { returns(T.nilable(T::Array[T.any(OpenAI::Responses::SkillReference, OpenAI::Responses::InlineSkill)])) }
      attr_reader :skills

      sig {
        params(
          skills: T::Array[T.any(OpenAI::Responses::SkillReference::OrHash, OpenAI::Responses::InlineSkill::OrHash)]
        )
          .void
      }
      attr_writer :skills

      sig do
        params(

          name: String,

          expires_after: OpenAI::ContainerCreateParams::ExpiresAfter::OrHash,

          file_ids: T::Array[String],

          memory_limit: OpenAI::ContainerCreateParams::MemoryLimit::OrSymbol,

          network_policy: T.any(
            OpenAI::Responses::ContainerNetworkPolicyDisabled::OrHash,
            OpenAI::Responses::ContainerNetworkPolicyAllowlist::OrHash
          ),

          skills: T::Array[T.any(OpenAI::Responses::SkillReference::OrHash, OpenAI::Responses::InlineSkill::OrHash)],

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # Name of the container to create.
        name:,

        # Container expiration time in seconds relative to the 'anchor' time.
        expires_after: nil,

        # IDs of files to copy to the container.
        file_ids: nil,

        # Optional memory limit for the container. Defaults to "1g".
        memory_limit: nil,

        # Network access policy for the container.
        network_policy: nil,

        # An optional list of skills referenced by id or inline data.
        skills: nil,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            name: String,
            expires_after: OpenAI::ContainerCreateParams::ExpiresAfter,
            file_ids: T::Array[String],
            memory_limit: OpenAI::ContainerCreateParams::MemoryLimit::OrSymbol,
            network_policy: T.any(
              OpenAI::Responses::ContainerNetworkPolicyDisabled,
              OpenAI::Responses::ContainerNetworkPolicyAllowlist
            ),
            skills: T::Array[T.any(OpenAI::Responses::SkillReference, OpenAI::Responses::InlineSkill)],
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::ContainerCreateParams::ExpiresAfter,
            OpenAI::Internal::AnyHash
          )
        end

        # Time anchor for the expiration time. Currently only 'last_active_at' is
        # supported.
        sig { returns(OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::OrSymbol) }
        attr_accessor :anchor

        sig { returns(Integer) }
        attr_accessor :minutes

        # Container expiration time in seconds relative to the 'anchor' time.
        sig do
          params(

            anchor: OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::OrSymbol,

            minutes: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Time anchor for the expiration time. Currently only 'last_active_at' is
          # supported.
          anchor:,

          minutes:
        )
        end

        sig do
          override.returns(
            {anchor: OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::OrSymbol, minutes: Integer}
          )
        end
        def to_hash
        end

        # Time anchor for the expiration time. Currently only 'last_active_at' is
        # supported.
        module Anchor
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ContainerCreateParams::ExpiresAfter::Anchor) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LAST_ACTIVE_AT = T.let(:last_active_at, OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::TaggedSymbol]) }
          def self.values
          end
        end
      end

      # Optional memory limit for the container. Defaults to "1g".
      module MemoryLimit
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ContainerCreateParams::MemoryLimit) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        MEMORY_LIMIT_1G = T.let(:"1g", OpenAI::ContainerCreateParams::MemoryLimit::TaggedSymbol)
        MEMORY_LIMIT_4G = T.let(:"4g", OpenAI::ContainerCreateParams::MemoryLimit::TaggedSymbol)
        MEMORY_LIMIT_16G = T.let(:"16g", OpenAI::ContainerCreateParams::MemoryLimit::TaggedSymbol)
        MEMORY_LIMIT_64G = T.let(:"64g", OpenAI::ContainerCreateParams::MemoryLimit::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ContainerCreateParams::MemoryLimit::TaggedSymbol]) }
        def self.values
        end
      end

      # Network access policy for the container.
      module NetworkPolicy
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(OpenAI::Responses::ContainerNetworkPolicyDisabled, OpenAI::Responses::ContainerNetworkPolicyAllowlist)
        }

        sig { override.returns(T::Array[OpenAI::ContainerCreateParams::NetworkPolicy::Variants]) }
        def self.variants
        end

      end

      module Skill
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(OpenAI::Responses::SkillReference, OpenAI::Responses::InlineSkill) }

        sig { override.returns(T::Array[OpenAI::ContainerCreateParams::Skill::Variants]) }
        def self.variants
        end

      end

    end

  end
end
