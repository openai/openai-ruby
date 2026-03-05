# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::FineTuning::Checkpoints::PermissionListParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :fine_tuned_model_checkpoint

          # Identifier for the last permission ID from the previous pagination request.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Number of permissions to retrieve.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # The order in which to retrieve permissions.
          sig do
            returns(
              T.nilable(
                OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order:
                OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          # The ID of the project to get permissions for.
          sig { returns(T.nilable(String)) }
          attr_reader :project_id

          sig { params(project_id: String).void }
          attr_writer :project_id

          sig do
            params(
              fine_tuned_model_checkpoint: String,
              after: String,
              limit: Integer,
              order:
                OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::OrSymbol,
              project_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            fine_tuned_model_checkpoint:,
            # Identifier for the last permission ID from the previous pagination request.
            after: nil,
            # Number of permissions to retrieve.
            limit: nil,
            # The order in which to retrieve permissions.
            order: nil,
            # The ID of the project to get permissions for.
            project_id: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                fine_tuned_model_checkpoint: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::OrSymbol,
                project_id: String,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # The order in which to retrieve permissions.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::FineTuning::Checkpoints::PermissionListParams::Order
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASCENDING =
              T.let(
                :ascending,
                OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::TaggedSymbol
              )
            DESCENDING =
              T.let(
                :descending,
                OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::Checkpoints::PermissionListParams::Order::TaggedSymbol
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
