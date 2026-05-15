# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class InviteCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::InviteCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Send an email to this address
          sig { returns(String) }
          attr_accessor :email

          # `owner` or `reader`
          sig do
            returns(
              OpenAI::Admin::Organization::InviteCreateParams::Role::OrSymbol
            )
          end
          attr_accessor :role

          # An array of projects to which membership is granted at the same time the org
          # invite is accepted. If omitted, the user will be invited to the default project
          # for compatibility with legacy behavior. If empty list is passed, the user will
          # not be invited to any projects, including the default one.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Admin::Organization::InviteCreateParams::Project
                ]
              )
            )
          end
          attr_reader :projects

          sig do
            params(
              projects:
                T::Array[
                  OpenAI::Admin::Organization::InviteCreateParams::Project::OrHash
                ]
            ).void
          end
          attr_writer :projects

          sig do
            params(
              email: String,
              role:
                OpenAI::Admin::Organization::InviteCreateParams::Role::OrSymbol,
              projects:
                T::Array[
                  OpenAI::Admin::Organization::InviteCreateParams::Project::OrHash
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Send an email to this address
            email:,
            # `owner` or `reader`
            role:,
            # An array of projects to which membership is granted at the same time the org
            # invite is accepted. If omitted, the user will be invited to the default project
            # for compatibility with legacy behavior. If empty list is passed, the user will
            # not be invited to any projects, including the default one.
            projects: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                email: String,
                role:
                  OpenAI::Admin::Organization::InviteCreateParams::Role::OrSymbol,
                projects:
                  T::Array[
                    OpenAI::Admin::Organization::InviteCreateParams::Project
                  ],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # `owner` or `reader`
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::InviteCreateParams::Role
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            READER =
              T.let(
                :reader,
                OpenAI::Admin::Organization::InviteCreateParams::Role::TaggedSymbol
              )
            OWNER =
              T.let(
                :owner,
                OpenAI::Admin::Organization::InviteCreateParams::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::InviteCreateParams::Role::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Project < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::InviteCreateParams::Project,
                  OpenAI::Internal::AnyHash
                )
              end

            # Project's public ID
            sig { returns(String) }
            attr_accessor :id

            # Project membership role
            sig do
              returns(
                OpenAI::Admin::Organization::InviteCreateParams::Project::Role::OrSymbol
              )
            end
            attr_accessor :role

            sig do
              params(
                id: String,
                role:
                  OpenAI::Admin::Organization::InviteCreateParams::Project::Role::OrSymbol
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
                    OpenAI::Admin::Organization::InviteCreateParams::Project::Role::OrSymbol
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
                    OpenAI::Admin::Organization::InviteCreateParams::Project::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::InviteCreateParams::Project::Role::TaggedSymbol
                )
              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::InviteCreateParams::Project::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::InviteCreateParams::Project::Role::TaggedSymbol
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
end
