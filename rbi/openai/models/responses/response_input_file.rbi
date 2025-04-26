# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputFile < OpenAI::Internal::Type::BaseModel
        # The type of the input item. Always `input_file`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The content of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_reader :file_data

        sig { params(file_data: String).void }
        attr_writer :file_data

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_reader :file_id

        sig { params(file_id: String).void }
        attr_writer :file_id

        # The name of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_reader :filename

        sig { params(filename: String).void }
        attr_writer :filename

        # A file input to the model.
        sig do
          params(file_data: String, file_id: String, filename: String, type: Symbol).returns(T.attached_class)
        end
        def self.new(
          # The content of the file to be sent to the model.
          file_data: nil,
          # The ID of the file to be sent to the model.
          file_id: nil,
          # The name of the file to be sent to the model.
          filename: nil,
          # The type of the input item. Always `input_file`.
          type: :input_file
        ); end
        sig { override.returns({type: Symbol, file_data: String, file_id: String, filename: String}) }
        def to_hash; end
      end
    end
  end
end
