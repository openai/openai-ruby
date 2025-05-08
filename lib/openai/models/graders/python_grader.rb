# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class PythonGrader < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the grader.
        #
        #   @return [String]
        required :name, String

        # @!attribute source
        #   The source code of the python script.
        #
        #   @return [String]
        required :source, String

        # @!attribute type
        #   The object type, which is always `python`.
        #
        #   @return [Symbol, :python]
        required :type, const: :python

        # @!attribute image_tag
        #   The image tag to use for the python script.
        #
        #   @return [String, nil]
        optional :image_tag, String

        # @!method initialize(name:, source:, image_tag: nil, type: :python)
        #   A PythonGrader object that runs a python script on the input.
        #
        #   @param name [String] The name of the grader.
        #
        #   @param source [String] The source code of the python script.
        #
        #   @param image_tag [String] The image tag to use for the python script.
        #
        #   @param type [Symbol, :python] The object type, which is always `python`.
      end
    end

    PythonGrader = Graders::PythonGrader
  end
end
