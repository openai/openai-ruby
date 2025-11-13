# typed: strong

module OpenAI
  module Models
    module Responses
      # A tool that can be used to generate a response.
      module Tool
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::FunctionTool,
              OpenAI::Responses::FileSearchTool,
              OpenAI::Responses::ComputerTool,
              OpenAI::Responses::Tool::Mcp,
              OpenAI::Responses::Tool::CodeInterpreter,
              OpenAI::Responses::Tool::ImageGeneration,
              OpenAI::Responses::Tool::LocalShell,
              OpenAI::Responses::FunctionShellTool,
              OpenAI::Responses::CustomTool,
              OpenAI::Responses::ApplyPatchTool,
              OpenAI::Responses::WebSearchTool,
              OpenAI::Responses::WebSearchPreviewTool
            )
          end

        class Mcp < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(OpenAI::Responses::Tool::Mcp, OpenAI::Internal::AnyHash)
            end

          # A label for this MCP server, used to identify it in tool calls.
          sig { returns(String) }
          attr_accessor :server_label

          # The type of the MCP tool. Always `mcp`.
          sig { returns(Symbol) }
          attr_accessor :type

          # List of allowed tool names or a filter object.
          sig do
            returns(
              T.nilable(
                T.any(
                  T::Array[String],
                  OpenAI::Responses::Tool::Mcp::AllowedTools::McpToolFilter
                )
              )
            )
          end
          attr_accessor :allowed_tools

          # An OAuth access token that can be used with a remote MCP server, either with a
          # custom MCP server URL or a service connector. Your application must handle the
          # OAuth authorization flow and provide the token here.
          sig { returns(T.nilable(String)) }
          attr_reader :authorization

          sig { params(authorization: String).void }
          attr_writer :authorization

          # Identifier for service connectors, like those available in ChatGPT. One of
          # `server_url` or `connector_id` must be provided. Learn more about service
          # connectors
          # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
          #
          # Currently supported `connector_id` values are:
          #
          # - Dropbox: `connector_dropbox`
          # - Gmail: `connector_gmail`
          # - Google Calendar: `connector_googlecalendar`
          # - Google Drive: `connector_googledrive`
          # - Microsoft Teams: `connector_microsoftteams`
          # - Outlook Calendar: `connector_outlookcalendar`
          # - Outlook Email: `connector_outlookemail`
          # - SharePoint: `connector_sharepoint`
          sig do
            returns(
              T.nilable(OpenAI::Responses::Tool::Mcp::ConnectorID::OrSymbol)
            )
          end
          attr_reader :connector_id

          sig do
            params(
              connector_id: OpenAI::Responses::Tool::Mcp::ConnectorID::OrSymbol
            ).void
          end
          attr_writer :connector_id

          # Optional HTTP headers to send to the MCP server. Use for authentication or other
          # purposes.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :headers

          # Specify which of the MCP server's tools require approval.
          sig do
            returns(
              T.nilable(
                T.any(
                  OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter,
                  OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::OrSymbol
                )
              )
            )
          end
          attr_accessor :require_approval

          # Optional description of the MCP server, used to provide more context.
          sig { returns(T.nilable(String)) }
          attr_reader :server_description

          sig { params(server_description: String).void }
          attr_writer :server_description

          # The URL for the MCP server. One of `server_url` or `connector_id` must be
          # provided.
          sig { returns(T.nilable(String)) }
          attr_reader :server_url

          sig { params(server_url: String).void }
          attr_writer :server_url

          # Give the model access to additional tools via remote Model Context Protocol
          # (MCP) servers.
          # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
          sig do
            params(
              server_label: String,
              allowed_tools:
                T.nilable(
                  T.any(
                    T::Array[String],
                    OpenAI::Responses::Tool::Mcp::AllowedTools::McpToolFilter::OrHash
                  )
                ),
              authorization: String,
              connector_id: OpenAI::Responses::Tool::Mcp::ConnectorID::OrSymbol,
              headers: T.nilable(T::Hash[Symbol, String]),
              require_approval:
                T.nilable(
                  T.any(
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::OrHash,
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::OrSymbol
                  )
                ),
              server_description: String,
              server_url: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A label for this MCP server, used to identify it in tool calls.
            server_label:,
            # List of allowed tool names or a filter object.
            allowed_tools: nil,
            # An OAuth access token that can be used with a remote MCP server, either with a
            # custom MCP server URL or a service connector. Your application must handle the
            # OAuth authorization flow and provide the token here.
            authorization: nil,
            # Identifier for service connectors, like those available in ChatGPT. One of
            # `server_url` or `connector_id` must be provided. Learn more about service
            # connectors
            # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
            #
            # Currently supported `connector_id` values are:
            #
            # - Dropbox: `connector_dropbox`
            # - Gmail: `connector_gmail`
            # - Google Calendar: `connector_googlecalendar`
            # - Google Drive: `connector_googledrive`
            # - Microsoft Teams: `connector_microsoftteams`
            # - Outlook Calendar: `connector_outlookcalendar`
            # - Outlook Email: `connector_outlookemail`
            # - SharePoint: `connector_sharepoint`
            connector_id: nil,
            # Optional HTTP headers to send to the MCP server. Use for authentication or other
            # purposes.
            headers: nil,
            # Specify which of the MCP server's tools require approval.
            require_approval: nil,
            # Optional description of the MCP server, used to provide more context.
            server_description: nil,
            # The URL for the MCP server. One of `server_url` or `connector_id` must be
            # provided.
            server_url: nil,
            # The type of the MCP tool. Always `mcp`.
            type: :mcp
          )
          end

          sig do
            override.returns(
              {
                server_label: String,
                type: Symbol,
                allowed_tools:
                  T.nilable(
                    T.any(
                      T::Array[String],
                      OpenAI::Responses::Tool::Mcp::AllowedTools::McpToolFilter
                    )
                  ),
                authorization: String,
                connector_id:
                  OpenAI::Responses::Tool::Mcp::ConnectorID::OrSymbol,
                headers: T.nilable(T::Hash[Symbol, String]),
                require_approval:
                  T.nilable(
                    T.any(
                      OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter,
                      OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::OrSymbol
                    )
                  ),
                server_description: String,
                server_url: String
              }
            )
          end
          def to_hash
          end

          # List of allowed tool names or a filter object.
          module AllowedTools
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  T::Array[String],
                  OpenAI::Responses::Tool::Mcp::AllowedTools::McpToolFilter
                )
              end

            class McpToolFilter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Responses::Tool::Mcp::AllowedTools::McpToolFilter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Indicates whether or not a tool modifies data or is read-only. If an MCP server
              # is
              # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
              # it will match this filter.
              sig { returns(T.nilable(T::Boolean)) }
              attr_reader :read_only

              sig { params(read_only: T::Boolean).void }
              attr_writer :read_only

              # List of allowed tool names.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :tool_names

              sig { params(tool_names: T::Array[String]).void }
              attr_writer :tool_names

              # A filter object to specify which tools are allowed.
              sig do
                params(
                  read_only: T::Boolean,
                  tool_names: T::Array[String]
                ).returns(T.attached_class)
              end
              def self.new(
                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                read_only: nil,
                # List of allowed tool names.
                tool_names: nil
              )
              end

              sig do
                override.returns(
                  { read_only: T::Boolean, tool_names: T::Array[String] }
                )
              end
              def to_hash
              end
            end

            sig do
              override.returns(
                T::Array[OpenAI::Responses::Tool::Mcp::AllowedTools::Variants]
              )
            end
            def self.variants
            end

            StringArray =
              T.let(
                OpenAI::Internal::Type::ArrayOf[String],
                OpenAI::Internal::Type::Converter
              )
          end

          # Identifier for service connectors, like those available in ChatGPT. One of
          # `server_url` or `connector_id` must be provided. Learn more about service
          # connectors
          # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
          #
          # Currently supported `connector_id` values are:
          #
          # - Dropbox: `connector_dropbox`
          # - Gmail: `connector_gmail`
          # - Google Calendar: `connector_googlecalendar`
          # - Google Drive: `connector_googledrive`
          # - Microsoft Teams: `connector_microsoftteams`
          # - Outlook Calendar: `connector_outlookcalendar`
          # - Outlook Email: `connector_outlookemail`
          # - SharePoint: `connector_sharepoint`
          module ConnectorID
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Responses::Tool::Mcp::ConnectorID)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CONNECTOR_DROPBOX =
              T.let(
                :connector_dropbox,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_GMAIL =
              T.let(
                :connector_gmail,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_GOOGLECALENDAR =
              T.let(
                :connector_googlecalendar,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_GOOGLEDRIVE =
              T.let(
                :connector_googledrive,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_MICROSOFTTEAMS =
              T.let(
                :connector_microsoftteams,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_OUTLOOKCALENDAR =
              T.let(
                :connector_outlookcalendar,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_OUTLOOKEMAIL =
              T.let(
                :connector_outlookemail,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_SHAREPOINT =
              T.let(
                :connector_sharepoint,
                OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::Mcp::ConnectorID::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Specify which of the MCP server's tools require approval.
          module RequireApproval
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter,
                  OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                )
              end

            class McpToolApprovalFilter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # A filter object to specify which tools are allowed.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always
                  )
                )
              end
              attr_reader :always

              sig do
                params(
                  always:
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always::OrHash
                ).void
              end
              attr_writer :always

              # A filter object to specify which tools are allowed.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never
                  )
                )
              end
              attr_reader :never

              sig do
                params(
                  never:
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never::OrHash
                ).void
              end
              attr_writer :never

              # Specify which of the MCP server's tools require approval. Can be `always`,
              # `never`, or a filter object associated with tools that require approval.
              sig do
                params(
                  always:
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always::OrHash,
                  never:
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # A filter object to specify which tools are allowed.
                always: nil,
                # A filter object to specify which tools are allowed.
                never: nil
              )
              end

              sig do
                override.returns(
                  {
                    always:
                      OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always,
                    never:
                      OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never
                  }
                )
              end
              def to_hash
              end

              class Always < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :read_only

                sig { params(read_only: T::Boolean).void }
                attr_writer :read_only

                # List of allowed tool names.
                sig { returns(T.nilable(T::Array[String])) }
                attr_reader :tool_names

                sig { params(tool_names: T::Array[String]).void }
                attr_writer :tool_names

                # A filter object to specify which tools are allowed.
                sig do
                  params(
                    read_only: T::Boolean,
                    tool_names: T::Array[String]
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  read_only: nil,
                  # List of allowed tool names.
                  tool_names: nil
                )
                end

                sig do
                  override.returns(
                    { read_only: T::Boolean, tool_names: T::Array[String] }
                  )
                end
                def to_hash
                end
              end

              class Never < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :read_only

                sig { params(read_only: T::Boolean).void }
                attr_writer :read_only

                # List of allowed tool names.
                sig { returns(T.nilable(T::Array[String])) }
                attr_reader :tool_names

                sig { params(tool_names: T::Array[String]).void }
                attr_writer :tool_names

                # A filter object to specify which tools are allowed.
                sig do
                  params(
                    read_only: T::Boolean,
                    tool_names: T::Array[String]
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  read_only: nil,
                  # List of allowed tool names.
                  tool_names: nil
                )
                end

                sig do
                  override.returns(
                    { read_only: T::Boolean, tool_names: T::Array[String] }
                  )
                end
                def to_hash
                end
              end
            end

            # Specify a single approval policy for all tools. One of `always` or `never`. When
            # set to `always`, all tools will require approval. When set to `never`, all tools
            # will not require approval.
            module McpToolApprovalSetting
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ALWAYS =
                T.let(
                  :always,
                  OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                )
              NEVER =
                T.let(
                  :never,
                  OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::Mcp::RequireApproval::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end

        class CodeInterpreter < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::Tool::CodeInterpreter,
                OpenAI::Internal::AnyHash
              )
            end

          # The code interpreter container. Can be a container ID or an object that
          # specifies uploaded file IDs to make available to your code.
          sig do
            returns(
              T.any(
                String,
                OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto
              )
            )
          end
          attr_accessor :container

          # The type of the code interpreter tool. Always `code_interpreter`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A tool that runs Python code to help generate a response to a prompt.
          sig do
            params(
              container:
                T.any(
                  String,
                  OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::OrHash
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The code interpreter container. Can be a container ID or an object that
            # specifies uploaded file IDs to make available to your code.
            container:,
            # The type of the code interpreter tool. Always `code_interpreter`.
            type: :code_interpreter
          )
          end

          sig do
            override.returns(
              {
                container:
                  T.any(
                    String,
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto
                  ),
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # The code interpreter container. Can be a container ID or an object that
          # specifies uploaded file IDs to make available to your code.
          module Container
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto
                )
              end

            class CodeInterpreterToolAuto < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Always `auto`.
              sig { returns(Symbol) }
              attr_accessor :type

              # An optional list of uploaded files to make available to your code.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :file_ids

              sig { params(file_ids: T::Array[String]).void }
              attr_writer :file_ids

              sig do
                returns(
                  T.nilable(
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::OrSymbol
                  )
                )
              end
              attr_accessor :memory_limit

              # Configuration for a code interpreter container. Optionally specify the IDs of
              # the files to run the code on.
              sig do
                params(
                  file_ids: T::Array[String],
                  memory_limit:
                    T.nilable(
                      OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::OrSymbol
                    ),
                  type: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # An optional list of uploaded files to make available to your code.
                file_ids: nil,
                memory_limit: nil,
                # Always `auto`.
                type: :auto
              )
              end

              sig do
                override.returns(
                  {
                    type: Symbol,
                    file_ids: T::Array[String],
                    memory_limit:
                      T.nilable(
                        OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::OrSymbol
                      )
                  }
                )
              end
              def to_hash
              end

              module MemoryLimit
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                MEMORY_LIMIT_1G =
                  T.let(
                    :"1g",
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::TaggedSymbol
                  )
                MEMORY_LIMIT_4G =
                  T.let(
                    :"4g",
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::TaggedSymbol
                  )
                MEMORY_LIMIT_16G =
                  T.let(
                    :"16g",
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::TaggedSymbol
                  )
                MEMORY_LIMIT_64G =
                  T.let(
                    :"64g",
                    OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto::MemoryLimit::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::CodeInterpreter::Container::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end

        class ImageGeneration < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::Tool::ImageGeneration,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of the image generation tool. Always `image_generation`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Background type for the generated image. One of `transparent`, `opaque`, or
          # `auto`. Default: `auto`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::Background::OrSymbol
              )
            )
          end
          attr_reader :background

          sig do
            params(
              background:
                OpenAI::Responses::Tool::ImageGeneration::Background::OrSymbol
            ).void
          end
          attr_writer :background

          # Control how much effort the model will exert to match the style and features,
          # especially facial features, of input images. This parameter is only supported
          # for `gpt-image-1`. Unsupported for `gpt-image-1-mini`. Supports `high` and
          # `low`. Defaults to `low`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::InputFidelity::OrSymbol
              )
            )
          end
          attr_accessor :input_fidelity

          # Optional mask for inpainting. Contains `image_url` (string, optional) and
          # `file_id` (string, optional).
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::InputImageMask
              )
            )
          end
          attr_reader :input_image_mask

          sig do
            params(
              input_image_mask:
                OpenAI::Responses::Tool::ImageGeneration::InputImageMask::OrHash
            ).void
          end
          attr_writer :input_image_mask

          # The image generation model to use. Default: `gpt-image-1`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::Model::OrSymbol
              )
            )
          end
          attr_reader :model

          sig do
            params(
              model: OpenAI::Responses::Tool::ImageGeneration::Model::OrSymbol
            ).void
          end
          attr_writer :model

          # Moderation level for the generated image. Default: `auto`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::Moderation::OrSymbol
              )
            )
          end
          attr_reader :moderation

          sig do
            params(
              moderation:
                OpenAI::Responses::Tool::ImageGeneration::Moderation::OrSymbol
            ).void
          end
          attr_writer :moderation

          # Compression level for the output image. Default: 100.
          sig { returns(T.nilable(Integer)) }
          attr_reader :output_compression

          sig { params(output_compression: Integer).void }
          attr_writer :output_compression

          # The output format of the generated image. One of `png`, `webp`, or `jpeg`.
          # Default: `png`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::OutputFormat::OrSymbol
              )
            )
          end
          attr_reader :output_format

          sig do
            params(
              output_format:
                OpenAI::Responses::Tool::ImageGeneration::OutputFormat::OrSymbol
            ).void
          end
          attr_writer :output_format

          # Number of partial images to generate in streaming mode, from 0 (default value)
          # to 3.
          sig { returns(T.nilable(Integer)) }
          attr_reader :partial_images

          sig { params(partial_images: Integer).void }
          attr_writer :partial_images

          # The quality of the generated image. One of `low`, `medium`, `high`, or `auto`.
          # Default: `auto`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::Quality::OrSymbol
              )
            )
          end
          attr_reader :quality

          sig do
            params(
              quality:
                OpenAI::Responses::Tool::ImageGeneration::Quality::OrSymbol
            ).void
          end
          attr_writer :quality

          # The size of the generated image. One of `1024x1024`, `1024x1536`, `1536x1024`,
          # or `auto`. Default: `auto`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::Tool::ImageGeneration::Size::OrSymbol
              )
            )
          end
          attr_reader :size

          sig do
            params(
              size: OpenAI::Responses::Tool::ImageGeneration::Size::OrSymbol
            ).void
          end
          attr_writer :size

          # A tool that generates images using a model like `gpt-image-1`.
          sig do
            params(
              background:
                OpenAI::Responses::Tool::ImageGeneration::Background::OrSymbol,
              input_fidelity:
                T.nilable(
                  OpenAI::Responses::Tool::ImageGeneration::InputFidelity::OrSymbol
                ),
              input_image_mask:
                OpenAI::Responses::Tool::ImageGeneration::InputImageMask::OrHash,
              model: OpenAI::Responses::Tool::ImageGeneration::Model::OrSymbol,
              moderation:
                OpenAI::Responses::Tool::ImageGeneration::Moderation::OrSymbol,
              output_compression: Integer,
              output_format:
                OpenAI::Responses::Tool::ImageGeneration::OutputFormat::OrSymbol,
              partial_images: Integer,
              quality:
                OpenAI::Responses::Tool::ImageGeneration::Quality::OrSymbol,
              size: OpenAI::Responses::Tool::ImageGeneration::Size::OrSymbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Background type for the generated image. One of `transparent`, `opaque`, or
            # `auto`. Default: `auto`.
            background: nil,
            # Control how much effort the model will exert to match the style and features,
            # especially facial features, of input images. This parameter is only supported
            # for `gpt-image-1`. Unsupported for `gpt-image-1-mini`. Supports `high` and
            # `low`. Defaults to `low`.
            input_fidelity: nil,
            # Optional mask for inpainting. Contains `image_url` (string, optional) and
            # `file_id` (string, optional).
            input_image_mask: nil,
            # The image generation model to use. Default: `gpt-image-1`.
            model: nil,
            # Moderation level for the generated image. Default: `auto`.
            moderation: nil,
            # Compression level for the output image. Default: 100.
            output_compression: nil,
            # The output format of the generated image. One of `png`, `webp`, or `jpeg`.
            # Default: `png`.
            output_format: nil,
            # Number of partial images to generate in streaming mode, from 0 (default value)
            # to 3.
            partial_images: nil,
            # The quality of the generated image. One of `low`, `medium`, `high`, or `auto`.
            # Default: `auto`.
            quality: nil,
            # The size of the generated image. One of `1024x1024`, `1024x1536`, `1536x1024`,
            # or `auto`. Default: `auto`.
            size: nil,
            # The type of the image generation tool. Always `image_generation`.
            type: :image_generation
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                background:
                  OpenAI::Responses::Tool::ImageGeneration::Background::OrSymbol,
                input_fidelity:
                  T.nilable(
                    OpenAI::Responses::Tool::ImageGeneration::InputFidelity::OrSymbol
                  ),
                input_image_mask:
                  OpenAI::Responses::Tool::ImageGeneration::InputImageMask,
                model:
                  OpenAI::Responses::Tool::ImageGeneration::Model::OrSymbol,
                moderation:
                  OpenAI::Responses::Tool::ImageGeneration::Moderation::OrSymbol,
                output_compression: Integer,
                output_format:
                  OpenAI::Responses::Tool::ImageGeneration::OutputFormat::OrSymbol,
                partial_images: Integer,
                quality:
                  OpenAI::Responses::Tool::ImageGeneration::Quality::OrSymbol,
                size: OpenAI::Responses::Tool::ImageGeneration::Size::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Background type for the generated image. One of `transparent`, `opaque`, or
          # `auto`. Default: `auto`.
          module Background
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::Tool::ImageGeneration::Background
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TRANSPARENT =
              T.let(
                :transparent,
                OpenAI::Responses::Tool::ImageGeneration::Background::TaggedSymbol
              )
            OPAQUE =
              T.let(
                :opaque,
                OpenAI::Responses::Tool::ImageGeneration::Background::TaggedSymbol
              )
            AUTO =
              T.let(
                :auto,
                OpenAI::Responses::Tool::ImageGeneration::Background::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::Background::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Control how much effort the model will exert to match the style and features,
          # especially facial features, of input images. This parameter is only supported
          # for `gpt-image-1`. Unsupported for `gpt-image-1-mini`. Supports `high` and
          # `low`. Defaults to `low`.
          module InputFidelity
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::Tool::ImageGeneration::InputFidelity
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            HIGH =
              T.let(
                :high,
                OpenAI::Responses::Tool::ImageGeneration::InputFidelity::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Responses::Tool::ImageGeneration::InputFidelity::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::InputFidelity::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class InputImageMask < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::Tool::ImageGeneration::InputImageMask,
                  OpenAI::Internal::AnyHash
                )
              end

            # File ID for the mask image.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            # Base64-encoded mask image.
            sig { returns(T.nilable(String)) }
            attr_reader :image_url

            sig { params(image_url: String).void }
            attr_writer :image_url

            # Optional mask for inpainting. Contains `image_url` (string, optional) and
            # `file_id` (string, optional).
            sig do
              params(file_id: String, image_url: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # File ID for the mask image.
              file_id: nil,
              # Base64-encoded mask image.
              image_url: nil
            )
            end

            sig { override.returns({ file_id: String, image_url: String }) }
            def to_hash
            end
          end

          # The image generation model to use. Default: `gpt-image-1`.
          module Model
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Responses::Tool::ImageGeneration::Model)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            GPT_IMAGE_1 =
              T.let(
                :"gpt-image-1",
                OpenAI::Responses::Tool::ImageGeneration::Model::TaggedSymbol
              )
            GPT_IMAGE_1_MINI =
              T.let(
                :"gpt-image-1-mini",
                OpenAI::Responses::Tool::ImageGeneration::Model::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::Model::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Moderation level for the generated image. Default: `auto`.
          module Moderation
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::Tool::ImageGeneration::Moderation
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Responses::Tool::ImageGeneration::Moderation::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Responses::Tool::ImageGeneration::Moderation::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::Moderation::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The output format of the generated image. One of `png`, `webp`, or `jpeg`.
          # Default: `png`.
          module OutputFormat
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::Tool::ImageGeneration::OutputFormat
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PNG =
              T.let(
                :png,
                OpenAI::Responses::Tool::ImageGeneration::OutputFormat::TaggedSymbol
              )
            WEBP =
              T.let(
                :webp,
                OpenAI::Responses::Tool::ImageGeneration::OutputFormat::TaggedSymbol
              )
            JPEG =
              T.let(
                :jpeg,
                OpenAI::Responses::Tool::ImageGeneration::OutputFormat::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::OutputFormat::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The quality of the generated image. One of `low`, `medium`, `high`, or `auto`.
          # Default: `auto`.
          module Quality
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Responses::Tool::ImageGeneration::Quality)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW =
              T.let(
                :low,
                OpenAI::Responses::Tool::ImageGeneration::Quality::TaggedSymbol
              )
            MEDIUM =
              T.let(
                :medium,
                OpenAI::Responses::Tool::ImageGeneration::Quality::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Responses::Tool::ImageGeneration::Quality::TaggedSymbol
              )
            AUTO =
              T.let(
                :auto,
                OpenAI::Responses::Tool::ImageGeneration::Quality::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::Quality::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The size of the generated image. One of `1024x1024`, `1024x1536`, `1536x1024`,
          # or `auto`. Default: `auto`.
          module Size
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Responses::Tool::ImageGeneration::Size)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SIZE_1024X1024 =
              T.let(
                :"1024x1024",
                OpenAI::Responses::Tool::ImageGeneration::Size::TaggedSymbol
              )
            SIZE_1024X1536 =
              T.let(
                :"1024x1536",
                OpenAI::Responses::Tool::ImageGeneration::Size::TaggedSymbol
              )
            SIZE_1536X1024 =
              T.let(
                :"1536x1024",
                OpenAI::Responses::Tool::ImageGeneration::Size::TaggedSymbol
              )
            AUTO =
              T.let(
                :auto,
                OpenAI::Responses::Tool::ImageGeneration::Size::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::Tool::ImageGeneration::Size::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class LocalShell < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::Tool::LocalShell,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of the local shell tool. Always `local_shell`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A tool that allows the model to execute shell commands in a local environment.
          sig { params(type: Symbol).returns(T.attached_class) }
          def self.new(
            # The type of the local shell tool. Always `local_shell`.
            type: :local_shell
          )
          end

          sig { override.returns({ type: Symbol }) }
          def to_hash
          end
        end

        sig { override.returns(T::Array[OpenAI::Responses::Tool::Variants]) }
        def self.variants
        end
      end
    end
  end
end
