# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionFileUpload < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionFileUpload,
                OpenAI::Internal::AnyHash
              )
            end

          # Indicates if uploads are enabled for the session.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # Maximum upload size in megabytes.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :max_file_size

          # Maximum number of uploads allowed during the session.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :max_files

          # Upload permissions and limits applied to the session.
          sig do
            params(
              enabled: T::Boolean,
              max_file_size: T.nilable(Integer),
              max_files: T.nilable(Integer)
            ).returns(T.attached_class)
          end
          def self.new(
            # Indicates if uploads are enabled for the session.
            enabled:,
            # Maximum upload size in megabytes.
            max_file_size:,
            # Maximum number of uploads allowed during the session.
            max_files:
          )
          end

          sig do
            override.returns(
              {
                enabled: T::Boolean,
                max_file_size: T.nilable(Integer),
                max_files: T.nilable(Integer)
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
