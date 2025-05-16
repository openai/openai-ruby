# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Threads#update
      class ThreadUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute tool_resources
        #   A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        #
        #   @return [OpenAI::Beta::ThreadUpdateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Beta::ThreadUpdateParams::ToolResources }, nil?: true

        # @!method initialize(metadata: nil, tool_resources: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::ThreadUpdateParams} for more details.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param tool_resources [OpenAI::Beta::ThreadUpdateParams::ToolResources, nil] A set of resources that are made available to the assistant's tools in this thre
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        class ToolResources < OpenAI::Internal::Type::BaseModel
          # @!attribute code_interpreter
          #
          #   @return [OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter, -> { OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter }

          # @!attribute file_search
          #
          #   @return [OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch }

          # @!method initialize(code_interpreter: nil, file_search: nil)
          #   A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
          #
          #   @param code_interpreter [OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter]
          #   @param file_search [OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch]

          # @see OpenAI::Beta::ThreadUpdateParams::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(file_ids: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter} for more
            #   details.
            #
            #   @param file_ids [Array<String>] A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
          end

          # @see OpenAI::Beta::ThreadUpdateParams::ToolResources#file_search
          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute vector_store_ids
            #   The
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this thread. There can be a maximum of 1 vector store attached to
            #   the thread.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(vector_store_ids: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch} for more details.
            #
            #   @param vector_store_ids [Array<String>] The [vector store](https://platform.openai.com/docs/api-reference/vector-stores/
          end
        end
      end
    end
  end
end
