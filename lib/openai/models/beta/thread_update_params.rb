# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ThreadUpdateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::HashOf[String], nil?: true

        # @!attribute tool_resources
        #   A set of resources that are made available to the assistant's tools in this
        #     thread. The resources are specific to the type of tool. For example, the
        #     `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #     tool requires a list of vector store IDs.
        #
        #   @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Models::Beta::ThreadUpdateParams::ToolResources }, nil?: true

        # @!parse
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param tool_resources [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, nil]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(metadata: nil, tool_resources: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        class ToolResources < OpenAI::BaseModel
          # @!attribute [r] code_interpreter
          #
          #   @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter,
                   -> { OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter }

          # @!parse
          #   # @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter]
          #   attr_writer :code_interpreter

          # @!attribute [r] file_search
          #
          #   @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch }

          # @!parse
          #   # @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch]
          #   attr_writer :file_search

          # @!parse
          #   # A set of resources that are made available to the assistant's tools in this
          #   #   thread. The resources are specific to the type of tool. For example, the
          #   #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   #   tool requires a list of vector store IDs.
          #   #
          #   # @param code_interpreter [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter]
          #   # @param file_search [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch]
          #   #
          #   def initialize(code_interpreter: nil, file_search: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          class CodeInterpreter < OpenAI::BaseModel
            # @!attribute [r] file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #     available to the `code_interpreter` tool. There can be a maximum of 20 files
            #     associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :file_ids

            # @!parse
            #   # @param file_ids [Array<String>]
            #   #
            #   def initialize(file_ids: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end

          class FileSearch < OpenAI::BaseModel
            # @!attribute [r] vector_store_ids
            #   The
            #     [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #     attached to this thread. There can be a maximum of 1 vector store attached to
            #     the thread.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :vector_store_ids

            # @!parse
            #   # @param vector_store_ids [Array<String>]
            #   #
            #   def initialize(vector_store_ids: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end
      end
    end
  end
end
