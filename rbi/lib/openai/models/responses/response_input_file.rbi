# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputFile < OpenAI::BaseModel
        # The type of the input item. Always `input_file`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The content of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        def file_data
        end

        sig { params(_: String).returns(String) }
        def file_data=(_)
        end

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        def file_id
        end

        sig { params(_: String).returns(String) }
        def file_id=(_)
        end

        # The name of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        def filename
        end

        sig { params(_: String).returns(String) }
        def filename=(_)
        end

        # A file input to the model.
        sig do
          params(file_data: String, file_id: String, filename: String, type: Symbol).returns(T.attached_class)
        end
        def self.new(file_data: nil, file_id: nil, filename: nil, type: :input_file)
        end

        sig { override.returns({type: Symbol, file_data: String, file_id: String, filename: String}) }
        def to_hash
        end
      end
    end
  end
end
