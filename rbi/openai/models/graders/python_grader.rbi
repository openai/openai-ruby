# typed: strong

module OpenAI
  module Models
    PythonGrader = Graders::PythonGrader

    module Graders
      class PythonGrader < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The name of the grader.
        sig { returns(String) }
        attr_accessor :name

        # The source code of the python script.
        sig { returns(String) }
        attr_accessor :source

        # The object type, which is always `python`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The image tag to use for the python script.
        sig { returns(T.nilable(String)) }
        attr_reader :image_tag

        sig { params(image_tag: String).void }
        attr_writer :image_tag

        # A PythonGrader object that runs a python script on the input.
        sig do
          params(
            name: String,
            source: String,
            image_tag: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the grader.
          name:,
          # The source code of the python script.
          source:,
          # The image tag to use for the python script.
          image_tag: nil,
          # The object type, which is always `python`.
          type: :python
        )
        end

        sig do
          override.returns(
            { name: String, source: String, type: Symbol, image_tag: String }
          )
        end
        def to_hash
        end
      end
    end
  end
end
