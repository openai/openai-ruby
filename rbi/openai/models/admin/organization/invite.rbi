# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class Invite < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Invite,
                OpenAI::Internal::AnyHash
              )
            end

          # The identifier, which can be referenced in API endpoints
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp (in seconds) of when the invite was sent.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The email address of the individual to whom the invite was sent
          sig { returns(String) }
          attr_accessor :email

          # The object type, which is always `organization.invite`
          sig { returns(Symbol) }
          attr_accessor :object

          # The projects that were granted membership upon acceptance of the invite.
          sig do
            returns(T::Array[OpenAI::Admin::Organization::Invite::Project])
          end
          attr_accessor :projects

          # `owner` or `reader`
          sig do
            returns(OpenAI::Admin::Organization::Invite::Role::TaggedSymbol)
          end
          attr_accessor :role

          # `accepted`,`expired`, or `pending`
          sig do
            returns(OpenAI::Admin::Organization::Invite::Status::TaggedSymbol)
          end
          attr_accessor :status

          # The Unix timestamp (in seconds) of when the invite was accepted.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :accepted_at

          # The Unix timestamp (in seconds) of when the invite expires.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :expires_at

          # Represents an individual `invite` to the organization.
          sig do
            params(
              id: String,
              created_at: Integer,
              email: String,
              projects:
                T::Array[OpenAI::Admin::Organization::Invite::Project::OrHash],
              role: OpenAI::Admin::Organization::Invite::Role::OrSymbol,
              status: OpenAI::Admin::Organization::Invite::Status::OrSymbol,
              accepted_at: T.nilable(Integer),
              expires_at: T.nilable(Integer),
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            # The Unix timestamp (in seconds) of when the invite was sent.
            created_at:,
            # The email address of the individual to whom the invite was sent
            email:,
            # The projects that were granted membership upon acceptance of the invite.
            projects:,
            # `owner` or `reader`
            role:,
            # `accepted`,`expired`, or `pending`
            status:,
            # The Unix timestamp (in seconds) of when the invite was accepted.
            accepted_at: nil,
            # The Unix timestamp (in seconds) of when the invite expires.
            expires_at: nil,
            # The object type, which is always `organization.invite`
            object: :"organization.invite"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                email: String,
                object: Symbol,
                projects:
                  T::Array[OpenAI::Admin::Organization::Invite::Project],
                role: OpenAI::Admin::Organization::Invite::Role::TaggedSymbol,
                status:
                  OpenAI::Admin::Organization::Invite::Status::TaggedSymbol,
                accepted_at: T.nilable(Integer),
                expires_at: T.nilable(Integer)
              }
            )
          end
          def to_hash
          end

          class Project < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Invite::Project,
                  OpenAI::Internal::AnyHash
                )
              end

            # Project's public ID
            sig { returns(String) }
            attr_accessor :id

            # Project membership role
            sig do
              returns(
                OpenAI::Admin::Organization::Invite::Project::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            sig do
              params(
                id: String,
                role:
                  OpenAI::Admin::Organization::Invite::Project::Role::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Project's public ID
              id:,
              # Project membership role
              role:
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  role:
                    OpenAI::Admin::Organization::Invite::Project::Role::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # Project membership role
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Invite::Project::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::Invite::Project::Role::TaggedSymbol
                )
              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::Invite::Project::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Invite::Project::Role::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          # `owner` or `reader`
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Admin::Organization::Invite::Role)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            OWNER =
              T.let(
                :owner,
                OpenAI::Admin::Organization::Invite::Role::TaggedSymbol
              )
            READER =
              T.let(
                :reader,
                OpenAI::Admin::Organization::Invite::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::Invite::Role::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # `accepted`,`expired`, or `pending`
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Admin::Organization::Invite::Status)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ACCEPTED =
              T.let(
                :accepted,
                OpenAI::Admin::Organization::Invite::Status::TaggedSymbol
              )
            EXPIRED =
              T.let(
                :expired,
                OpenAI::Admin::Organization::Invite::Status::TaggedSymbol
              )
            PENDING =
              T.let(
                :pending,
                OpenAI::Admin::Organization::Invite::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::Invite::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
