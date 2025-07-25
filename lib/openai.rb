# frozen_string_literal: true

# Standard libraries.
require "English"
require "cgi"
require "date"
require "erb"
require "etc"
require "json"
require "net/http"
require "pathname"
require "rbconfig"
require "securerandom"
require "stringio"
require "time"
require "uri"
# We already ship the preferred sorbet manifests in the package itself.
# `tapioca` currently does not offer us a way to opt out of unnecessary compilation.
if Object.const_defined?(:Tapioca) &&
   caller.chain([$PROGRAM_NAME]).chain(ARGV).any?(/tapioca/) &&
   ARGV.none?(/dsl/)
  return
end

# Gems.
require "connection_pool"

# Package files.
require_relative "openai/version"
require_relative "openai/internal/util"
require_relative "openai/internal/type/converter"
require_relative "openai/internal/type/unknown"
require_relative "openai/internal/type/boolean"
require_relative "openai/internal/type/file_input"
require_relative "openai/internal/type/enum"
require_relative "openai/internal/type/union"
require_relative "openai/internal/type/array_of"
require_relative "openai/internal/type/hash_of"
require_relative "openai/internal/type/base_model"
require_relative "openai/internal/type/base_page"
require_relative "openai/internal/type/base_stream"
require_relative "openai/internal/type/request_parameters"
require_relative "openai/internal"
require_relative "openai/request_options"
require_relative "openai/file_part"
require_relative "openai/errors"
require_relative "openai/internal/transport/base_client"
require_relative "openai/internal/transport/pooled_net_requester"
require_relative "openai/client"
require_relative "openai/internal/stream"
require_relative "openai/internal/cursor_page"
require_relative "openai/internal/page"
require_relative "openai/helpers/structured_output/json_schema_converter"
require_relative "openai/helpers/structured_output/boolean"
require_relative "openai/helpers/structured_output/enum_of"
require_relative "openai/helpers/structured_output/union_of"
require_relative "openai/helpers/structured_output/array_of"
require_relative "openai/helpers/structured_output/base_model"
require_relative "openai/helpers/structured_output/parsed_json"
require_relative "openai/helpers/structured_output"
require_relative "openai/structured_output"
require_relative "openai/models/reasoning_effort"
require_relative "openai/models/chat/chat_completion_message"
require_relative "openai/models/graders/score_model_grader"
require_relative "openai/models/graders/python_grader"
require_relative "openai/models/graders/text_similarity_grader"
require_relative "openai/models/fine_tuning/fine_tuning_job_wandb_integration_object"
require_relative "openai/models/responses/response_function_tool_call"
require_relative "openai/models/all_models"
require_relative "openai/models/audio/speech_create_params"
require_relative "openai/models/audio/speech_model"
require_relative "openai/models/audio/transcription"
require_relative "openai/models/audio/transcription_create_params"
require_relative "openai/models/audio/transcription_create_response"
require_relative "openai/models/audio/transcription_include"
require_relative "openai/models/audio/transcription_segment"
require_relative "openai/models/audio/transcription_stream_event"
require_relative "openai/models/audio/transcription_text_delta_event"
require_relative "openai/models/audio/transcription_text_done_event"
require_relative "openai/models/audio/transcription_verbose"
require_relative "openai/models/audio/transcription_word"
require_relative "openai/models/audio/translation"
require_relative "openai/models/audio/translation_create_params"
require_relative "openai/models/audio/translation_create_response"
require_relative "openai/models/audio/translation_verbose"
require_relative "openai/models/audio_model"
require_relative "openai/models/audio_response_format"
require_relative "openai/models/auto_file_chunking_strategy_param"
require_relative "openai/models/batch"
require_relative "openai/models/batch_cancel_params"
require_relative "openai/models/batch_create_params"
require_relative "openai/models/batch_error"
require_relative "openai/models/batch_list_params"
require_relative "openai/models/batch_request_counts"
require_relative "openai/models/batch_retrieve_params"
require_relative "openai/models/beta/assistant"
require_relative "openai/models/beta/assistant_create_params"
require_relative "openai/models/beta/assistant_deleted"
require_relative "openai/models/beta/assistant_delete_params"
require_relative "openai/models/beta/assistant_list_params"
require_relative "openai/models/beta/assistant_response_format_option"
require_relative "openai/models/beta/assistant_retrieve_params"
require_relative "openai/models/beta/assistant_stream_event"
require_relative "openai/models/beta/assistant_tool"
require_relative "openai/models/beta/assistant_tool_choice"
require_relative "openai/models/beta/assistant_tool_choice_function"
require_relative "openai/models/beta/assistant_tool_choice_option"
require_relative "openai/models/beta/assistant_update_params"
require_relative "openai/models/beta/code_interpreter_tool"
require_relative "openai/models/beta/file_search_tool"
require_relative "openai/models/beta/function_tool"
require_relative "openai/models/beta/message_stream_event"
require_relative "openai/models/beta/run_step_stream_event"
require_relative "openai/models/beta/run_stream_event"
require_relative "openai/models/beta/thread"
require_relative "openai/models/beta/thread_create_and_run_params"
require_relative "openai/models/beta/thread_create_params"
require_relative "openai/models/beta/thread_deleted"
require_relative "openai/models/beta/thread_delete_params"
require_relative "openai/models/beta/thread_retrieve_params"
require_relative "openai/models/beta/threads/annotation"
require_relative "openai/models/beta/threads/annotation_delta"
require_relative "openai/models/beta/threads/file_citation_annotation"
require_relative "openai/models/beta/threads/file_citation_delta_annotation"
require_relative "openai/models/beta/threads/file_path_annotation"
require_relative "openai/models/beta/threads/file_path_delta_annotation"
require_relative "openai/models/beta/threads/image_file"
require_relative "openai/models/beta/threads/image_file_content_block"
require_relative "openai/models/beta/threads/image_file_delta"
require_relative "openai/models/beta/threads/image_file_delta_block"
require_relative "openai/models/beta/threads/image_url"
require_relative "openai/models/beta/threads/image_url_content_block"
require_relative "openai/models/beta/threads/image_url_delta"
require_relative "openai/models/beta/threads/image_url_delta_block"
require_relative "openai/models/beta/threads/message"
require_relative "openai/models/beta/threads/message_content"
require_relative "openai/models/beta/threads/message_content_delta"
require_relative "openai/models/beta/threads/message_content_part_param"
require_relative "openai/models/beta/threads/message_create_params"
require_relative "openai/models/beta/threads/message_deleted"
require_relative "openai/models/beta/threads/message_delete_params"
require_relative "openai/models/beta/threads/message_delta"
require_relative "openai/models/beta/threads/message_delta_event"
require_relative "openai/models/beta/threads/message_list_params"
require_relative "openai/models/beta/threads/message_retrieve_params"
require_relative "openai/models/beta/threads/message_update_params"
require_relative "openai/models/beta/threads/refusal_content_block"
require_relative "openai/models/beta/threads/refusal_delta_block"
require_relative "openai/models/beta/threads/required_action_function_tool_call"
require_relative "openai/models/beta/threads/run"
require_relative "openai/models/beta/threads/run_cancel_params"
require_relative "openai/models/beta/threads/run_create_params"
require_relative "openai/models/beta/threads/run_list_params"
require_relative "openai/models/beta/threads/run_retrieve_params"
require_relative "openai/models/beta/threads/runs/code_interpreter_logs"
require_relative "openai/models/beta/threads/runs/code_interpreter_output_image"
require_relative "openai/models/beta/threads/runs/code_interpreter_tool_call"
require_relative "openai/models/beta/threads/runs/code_interpreter_tool_call_delta"
require_relative "openai/models/beta/threads/runs/file_search_tool_call"
require_relative "openai/models/beta/threads/runs/file_search_tool_call_delta"
require_relative "openai/models/beta/threads/runs/function_tool_call"
require_relative "openai/models/beta/threads/runs/function_tool_call_delta"
require_relative "openai/models/beta/threads/runs/message_creation_step_details"
require_relative "openai/models/beta/threads/runs/run_step"
require_relative "openai/models/beta/threads/runs/run_step_delta"
require_relative "openai/models/beta/threads/runs/run_step_delta_event"
require_relative "openai/models/beta/threads/runs/run_step_delta_message_delta"
require_relative "openai/models/beta/threads/runs/run_step_include"
require_relative "openai/models/beta/threads/runs/step_list_params"
require_relative "openai/models/beta/threads/runs/step_retrieve_params"
require_relative "openai/models/beta/threads/runs/tool_call"
require_relative "openai/models/beta/threads/runs/tool_call_delta"
require_relative "openai/models/beta/threads/runs/tool_call_delta_object"
require_relative "openai/models/beta/threads/runs/tool_calls_step_details"
require_relative "openai/models/beta/threads/run_status"
require_relative "openai/models/beta/threads/run_submit_tool_outputs_params"
require_relative "openai/models/beta/threads/run_update_params"
require_relative "openai/models/beta/threads/text"
require_relative "openai/models/beta/threads/text_content_block"
require_relative "openai/models/beta/threads/text_content_block_param"
require_relative "openai/models/beta/threads/text_delta"
require_relative "openai/models/beta/threads/text_delta_block"
require_relative "openai/models/beta/thread_stream_event"
require_relative "openai/models/beta/thread_update_params"
require_relative "openai/models/chat/chat_completion"
require_relative "openai/models/chat/chat_completion_assistant_message_param"
require_relative "openai/models/chat/chat_completion_audio"
require_relative "openai/models/chat/chat_completion_audio_param"
require_relative "openai/models/chat/chat_completion_chunk"
require_relative "openai/models/chat/chat_completion_content_part"
require_relative "openai/models/chat/chat_completion_content_part_image"
require_relative "openai/models/chat/chat_completion_content_part_input_audio"
require_relative "openai/models/chat/chat_completion_content_part_refusal"
require_relative "openai/models/chat/chat_completion_content_part_text"
require_relative "openai/models/chat/chat_completion_deleted"
require_relative "openai/models/chat/chat_completion_developer_message_param"
require_relative "openai/models/chat/chat_completion_function_call_option"
require_relative "openai/models/chat/chat_completion_function_message_param"
require_relative "openai/models/chat/chat_completion_message_param"
require_relative "openai/models/chat/chat_completion_message_tool_call"
require_relative "openai/models/chat/chat_completion_modality"
require_relative "openai/models/chat/chat_completion_named_tool_choice"
require_relative "openai/models/chat/chat_completion_prediction_content"
require_relative "openai/models/chat/chat_completion_reasoning_effort"
require_relative "openai/models/chat/chat_completion_role"
require_relative "openai/models/chat/chat_completion_store_message"
require_relative "openai/models/chat/chat_completion_stream_options"
require_relative "openai/models/chat/chat_completion_system_message_param"
require_relative "openai/models/chat/chat_completion_token_logprob"
require_relative "openai/models/chat/chat_completion_tool"
require_relative "openai/models/chat/chat_completion_tool_choice_option"
require_relative "openai/models/chat/chat_completion_tool_message_param"
require_relative "openai/models/chat/chat_completion_user_message_param"
require_relative "openai/models/chat/completion_create_params"
require_relative "openai/models/chat/completion_delete_params"
require_relative "openai/models/chat/completion_list_params"
require_relative "openai/models/chat/completion_retrieve_params"
require_relative "openai/models/chat/completions/message_list_params"
require_relative "openai/models/chat/completion_update_params"
require_relative "openai/models/chat_model"
require_relative "openai/models/comparison_filter"
require_relative "openai/models/completion"
require_relative "openai/models/completion_choice"
require_relative "openai/models/completion_create_params"
require_relative "openai/models/completion_usage"
require_relative "openai/models/compound_filter"
require_relative "openai/models/container_create_params"
require_relative "openai/models/container_create_response"
require_relative "openai/models/container_delete_params"
require_relative "openai/models/container_list_params"
require_relative "openai/models/container_list_response"
require_relative "openai/models/container_retrieve_params"
require_relative "openai/models/container_retrieve_response"
require_relative "openai/models/containers/file_create_params"
require_relative "openai/models/containers/file_create_response"
require_relative "openai/models/containers/file_delete_params"
require_relative "openai/models/containers/file_list_params"
require_relative "openai/models/containers/file_list_response"
require_relative "openai/models/containers/file_retrieve_params"
require_relative "openai/models/containers/file_retrieve_response"
require_relative "openai/models/containers/files/content_retrieve_params"
require_relative "openai/models/create_embedding_response"
require_relative "openai/models/embedding"
require_relative "openai/models/embedding_create_params"
require_relative "openai/models/embedding_model"
require_relative "openai/models/error_object"
require_relative "openai/models/eval_create_params"
require_relative "openai/models/eval_create_response"
require_relative "openai/models/eval_custom_data_source_config"
require_relative "openai/models/eval_delete_params"
require_relative "openai/models/eval_delete_response"
require_relative "openai/models/eval_list_params"
require_relative "openai/models/eval_list_response"
require_relative "openai/models/eval_retrieve_params"
require_relative "openai/models/eval_retrieve_response"
require_relative "openai/models/evals/create_eval_completions_run_data_source"
require_relative "openai/models/evals/create_eval_jsonl_run_data_source"
require_relative "openai/models/evals/eval_api_error"
require_relative "openai/models/evals/run_cancel_params"
require_relative "openai/models/evals/run_cancel_response"
require_relative "openai/models/evals/run_create_params"
require_relative "openai/models/evals/run_create_response"
require_relative "openai/models/evals/run_delete_params"
require_relative "openai/models/evals/run_delete_response"
require_relative "openai/models/evals/run_list_params"
require_relative "openai/models/evals/run_list_response"
require_relative "openai/models/evals/run_retrieve_params"
require_relative "openai/models/evals/run_retrieve_response"
require_relative "openai/models/evals/runs/output_item_list_params"
require_relative "openai/models/evals/runs/output_item_list_response"
require_relative "openai/models/evals/runs/output_item_retrieve_params"
require_relative "openai/models/evals/runs/output_item_retrieve_response"
require_relative "openai/models/eval_stored_completions_data_source_config"
require_relative "openai/models/eval_update_params"
require_relative "openai/models/eval_update_response"
require_relative "openai/models/file_chunking_strategy"
require_relative "openai/models/file_chunking_strategy_param"
require_relative "openai/models/file_content"
require_relative "openai/models/file_content_params"
require_relative "openai/models/file_create_params"
require_relative "openai/models/file_deleted"
require_relative "openai/models/file_delete_params"
require_relative "openai/models/file_list_params"
require_relative "openai/models/file_object"
require_relative "openai/models/file_purpose"
require_relative "openai/models/file_retrieve_params"
require_relative "openai/models/fine_tuning/alpha/grader_run_params"
require_relative "openai/models/fine_tuning/alpha/grader_run_response"
require_relative "openai/models/fine_tuning/alpha/grader_validate_params"
require_relative "openai/models/fine_tuning/alpha/grader_validate_response"
require_relative "openai/models/fine_tuning/checkpoints/permission_create_params"
require_relative "openai/models/fine_tuning/checkpoints/permission_create_response"
require_relative "openai/models/fine_tuning/checkpoints/permission_delete_params"
require_relative "openai/models/fine_tuning/checkpoints/permission_delete_response"
require_relative "openai/models/fine_tuning/checkpoints/permission_retrieve_params"
require_relative "openai/models/fine_tuning/checkpoints/permission_retrieve_response"
require_relative "openai/models/fine_tuning/dpo_hyperparameters"
require_relative "openai/models/fine_tuning/dpo_method"
require_relative "openai/models/fine_tuning/fine_tuning_job"
require_relative "openai/models/fine_tuning/fine_tuning_job_event"
require_relative "openai/models/fine_tuning/fine_tuning_job_integration"
require_relative "openai/models/fine_tuning/fine_tuning_job_wandb_integration"
require_relative "openai/models/fine_tuning/job_cancel_params"
require_relative "openai/models/fine_tuning/job_create_params"
require_relative "openai/models/fine_tuning/job_list_events_params"
require_relative "openai/models/fine_tuning/job_list_params"
require_relative "openai/models/fine_tuning/job_pause_params"
require_relative "openai/models/fine_tuning/job_resume_params"
require_relative "openai/models/fine_tuning/job_retrieve_params"
require_relative "openai/models/fine_tuning/jobs/checkpoint_list_params"
require_relative "openai/models/fine_tuning/jobs/fine_tuning_job_checkpoint"
require_relative "openai/models/fine_tuning/reinforcement_hyperparameters"
require_relative "openai/models/fine_tuning/reinforcement_method"
require_relative "openai/models/fine_tuning/supervised_hyperparameters"
require_relative "openai/models/fine_tuning/supervised_method"
require_relative "openai/models/function_definition"
require_relative "openai/models/function_parameters"
require_relative "openai/models/graders/label_model_grader"
require_relative "openai/models/graders/multi_grader"
require_relative "openai/models/graders/string_check_grader"
require_relative "openai/models/image"
require_relative "openai/models/image_create_variation_params"
require_relative "openai/models/image_edit_completed_event"
require_relative "openai/models/image_edit_params"
require_relative "openai/models/image_edit_partial_image_event"
require_relative "openai/models/image_edit_stream_event"
require_relative "openai/models/image_gen_completed_event"
require_relative "openai/models/image_generate_params"
require_relative "openai/models/image_gen_partial_image_event"
require_relative "openai/models/image_gen_stream_event"
require_relative "openai/models/image_model"
require_relative "openai/models/images_response"
require_relative "openai/models/metadata"
require_relative "openai/models/model"
require_relative "openai/models/model_deleted"
require_relative "openai/models/model_delete_params"
require_relative "openai/models/model_list_params"
require_relative "openai/models/model_retrieve_params"
require_relative "openai/models/moderation"
require_relative "openai/models/moderation_create_params"
require_relative "openai/models/moderation_create_response"
require_relative "openai/models/moderation_image_url_input"
require_relative "openai/models/moderation_model"
require_relative "openai/models/moderation_multi_modal_input"
require_relative "openai/models/moderation_text_input"
require_relative "openai/models/other_file_chunking_strategy_object"
require_relative "openai/models/reasoning"
require_relative "openai/models/response_format_json_object"
require_relative "openai/models/response_format_json_schema"
require_relative "openai/models/response_format_text"
require_relative "openai/models/responses/computer_tool"
require_relative "openai/models/responses/easy_input_message"
require_relative "openai/models/responses/file_search_tool"
require_relative "openai/models/responses/function_tool"
require_relative "openai/models/responses/input_item_list_params"
require_relative "openai/models/responses/response"
require_relative "openai/models/responses/response_audio_delta_event"
require_relative "openai/models/responses/response_audio_done_event"
require_relative "openai/models/responses/response_audio_transcript_delta_event"
require_relative "openai/models/responses/response_audio_transcript_done_event"
require_relative "openai/models/responses/response_cancel_params"
require_relative "openai/models/responses/response_code_interpreter_call_code_delta_event"
require_relative "openai/models/responses/response_code_interpreter_call_code_done_event"
require_relative "openai/models/responses/response_code_interpreter_call_completed_event"
require_relative "openai/models/responses/response_code_interpreter_call_in_progress_event"
require_relative "openai/models/responses/response_code_interpreter_call_interpreting_event"
require_relative "openai/models/responses/response_code_interpreter_tool_call"
require_relative "openai/models/responses/response_completed_event"
require_relative "openai/models/responses/response_computer_tool_call"
require_relative "openai/models/responses/response_computer_tool_call_output_item"
require_relative "openai/models/responses/response_computer_tool_call_output_screenshot"
require_relative "openai/models/responses/response_content"
require_relative "openai/models/responses/response_content_part_added_event"
require_relative "openai/models/responses/response_content_part_done_event"
require_relative "openai/models/responses/response_created_event"
require_relative "openai/models/responses/response_create_params"
require_relative "openai/models/responses/response_delete_params"
require_relative "openai/models/responses/response_error"
require_relative "openai/models/responses/response_error_event"
require_relative "openai/models/responses/response_failed_event"
require_relative "openai/models/responses/response_file_search_call_completed_event"
require_relative "openai/models/responses/response_file_search_call_in_progress_event"
require_relative "openai/models/responses/response_file_search_call_searching_event"
require_relative "openai/models/responses/response_file_search_tool_call"
require_relative "openai/models/responses/response_format_text_config"
require_relative "openai/models/responses/response_format_text_json_schema_config"
require_relative "openai/models/responses/response_function_call_arguments_delta_event"
require_relative "openai/models/responses/response_function_call_arguments_done_event"
require_relative "openai/models/responses/response_function_tool_call_item"
require_relative "openai/models/responses/response_function_tool_call_output_item"
require_relative "openai/models/responses/response_function_web_search"
require_relative "openai/models/responses/response_image_gen_call_completed_event"
require_relative "openai/models/responses/response_image_gen_call_generating_event"
require_relative "openai/models/responses/response_image_gen_call_in_progress_event"
require_relative "openai/models/responses/response_image_gen_call_partial_image_event"
require_relative "openai/models/responses/response_includable"
require_relative "openai/models/responses/response_incomplete_event"
require_relative "openai/models/responses/response_in_progress_event"
require_relative "openai/models/responses/response_input"
require_relative "openai/models/responses/response_input_audio"
require_relative "openai/models/responses/response_input_content"
require_relative "openai/models/responses/response_input_file"
require_relative "openai/models/responses/response_input_image"
require_relative "openai/models/responses/response_input_item"
require_relative "openai/models/responses/response_input_message_content_list"
require_relative "openai/models/responses/response_input_message_item"
require_relative "openai/models/responses/response_input_text"
require_relative "openai/models/responses/response_item"
require_relative "openai/models/responses/response_item_list"
require_relative "openai/models/responses/response_mcp_call_arguments_delta_event"
require_relative "openai/models/responses/response_mcp_call_arguments_done_event"
require_relative "openai/models/responses/response_mcp_call_completed_event"
require_relative "openai/models/responses/response_mcp_call_failed_event"
require_relative "openai/models/responses/response_mcp_call_in_progress_event"
require_relative "openai/models/responses/response_mcp_list_tools_completed_event"
require_relative "openai/models/responses/response_mcp_list_tools_failed_event"
require_relative "openai/models/responses/response_mcp_list_tools_in_progress_event"
require_relative "openai/models/responses/response_output_audio"
require_relative "openai/models/responses/response_output_item"
require_relative "openai/models/responses/response_output_item_added_event"
require_relative "openai/models/responses/response_output_item_done_event"
require_relative "openai/models/responses/response_output_message"
require_relative "openai/models/responses/response_output_refusal"
require_relative "openai/models/responses/response_output_text"
require_relative "openai/models/responses/response_output_text_annotation_added_event"
require_relative "openai/models/responses/response_prompt"
require_relative "openai/models/responses/response_queued_event"
require_relative "openai/models/responses/response_reasoning_item"
require_relative "openai/models/responses/response_reasoning_summary_delta_event"
require_relative "openai/models/responses/response_reasoning_summary_done_event"
require_relative "openai/models/responses/response_reasoning_summary_part_added_event"
require_relative "openai/models/responses/response_reasoning_summary_part_done_event"
require_relative "openai/models/responses/response_reasoning_summary_text_delta_event"
require_relative "openai/models/responses/response_reasoning_summary_text_done_event"
require_relative "openai/models/responses/response_refusal_delta_event"
require_relative "openai/models/responses/response_refusal_done_event"
require_relative "openai/models/responses/response_retrieve_params"
require_relative "openai/models/responses/response_status"
require_relative "openai/models/responses/response_stream_event"
require_relative "openai/models/responses/response_text_config"
require_relative "openai/models/responses/response_text_delta_event"
require_relative "openai/models/responses/response_text_done_event"
require_relative "openai/models/responses/response_usage"
require_relative "openai/models/responses/response_web_search_call_completed_event"
require_relative "openai/models/responses/response_web_search_call_in_progress_event"
require_relative "openai/models/responses/response_web_search_call_searching_event"
require_relative "openai/models/responses/tool"
require_relative "openai/models/responses/tool_choice_function"
require_relative "openai/models/responses/tool_choice_mcp"
require_relative "openai/models/responses/tool_choice_options"
require_relative "openai/models/responses/tool_choice_types"
require_relative "openai/models/responses/web_search_tool"
require_relative "openai/models/responses_model"
require_relative "openai/models/static_file_chunking_strategy"
require_relative "openai/models/static_file_chunking_strategy_object"
require_relative "openai/models/static_file_chunking_strategy_object_param"
require_relative "openai/models/upload"
require_relative "openai/models/upload_cancel_params"
require_relative "openai/models/upload_complete_params"
require_relative "openai/models/upload_create_params"
require_relative "openai/models/uploads/part_create_params"
require_relative "openai/models/uploads/upload_part"
require_relative "openai/models/vector_store"
require_relative "openai/models/vector_store_create_params"
require_relative "openai/models/vector_store_deleted"
require_relative "openai/models/vector_store_delete_params"
require_relative "openai/models/vector_store_list_params"
require_relative "openai/models/vector_store_retrieve_params"
require_relative "openai/models/vector_stores/file_batch_cancel_params"
require_relative "openai/models/vector_stores/file_batch_create_params"
require_relative "openai/models/vector_stores/file_batch_list_files_params"
require_relative "openai/models/vector_stores/file_batch_retrieve_params"
require_relative "openai/models/vector_stores/file_content_params"
require_relative "openai/models/vector_stores/file_content_response"
require_relative "openai/models/vector_stores/file_create_params"
require_relative "openai/models/vector_stores/file_delete_params"
require_relative "openai/models/vector_stores/file_list_params"
require_relative "openai/models/vector_stores/file_retrieve_params"
require_relative "openai/models/vector_stores/file_update_params"
require_relative "openai/models/vector_stores/vector_store_file"
require_relative "openai/models/vector_stores/vector_store_file_batch"
require_relative "openai/models/vector_stores/vector_store_file_deleted"
require_relative "openai/models/vector_store_search_params"
require_relative "openai/models/vector_store_search_response"
require_relative "openai/models/vector_store_update_params"
require_relative "openai/models/webhooks/batch_cancelled_webhook_event"
require_relative "openai/models/webhooks/batch_completed_webhook_event"
require_relative "openai/models/webhooks/batch_expired_webhook_event"
require_relative "openai/models/webhooks/batch_failed_webhook_event"
require_relative "openai/models/webhooks/eval_run_canceled_webhook_event"
require_relative "openai/models/webhooks/eval_run_failed_webhook_event"
require_relative "openai/models/webhooks/eval_run_succeeded_webhook_event"
require_relative "openai/models/webhooks/fine_tuning_job_cancelled_webhook_event"
require_relative "openai/models/webhooks/fine_tuning_job_failed_webhook_event"
require_relative "openai/models/webhooks/fine_tuning_job_succeeded_webhook_event"
require_relative "openai/models/webhooks/response_cancelled_webhook_event"
require_relative "openai/models/webhooks/response_completed_webhook_event"
require_relative "openai/models/webhooks/response_failed_webhook_event"
require_relative "openai/models/webhooks/response_incomplete_webhook_event"
require_relative "openai/models/webhooks/unwrap_webhook_event"
require_relative "openai/models/webhooks/webhook_unwrap_params"
require_relative "openai/models"
require_relative "openai/resources/audio"
require_relative "openai/resources/audio/speech"
require_relative "openai/resources/audio/transcriptions"
require_relative "openai/resources/audio/translations"
require_relative "openai/resources/batches"
require_relative "openai/resources/beta"
require_relative "openai/resources/beta/assistants"
require_relative "openai/resources/beta/threads"
require_relative "openai/resources/beta/threads/messages"
require_relative "openai/resources/beta/threads/runs"
require_relative "openai/resources/beta/threads/runs/steps"
require_relative "openai/resources/chat"
require_relative "openai/resources/chat/completions"
require_relative "openai/resources/chat/completions/messages"
require_relative "openai/resources/completions"
require_relative "openai/resources/containers"
require_relative "openai/resources/containers/files"
require_relative "openai/resources/containers/files/content"
require_relative "openai/resources/embeddings"
require_relative "openai/resources/evals"
require_relative "openai/resources/evals/runs"
require_relative "openai/resources/evals/runs/output_items"
require_relative "openai/resources/files"
require_relative "openai/resources/fine_tuning"
require_relative "openai/resources/fine_tuning/alpha"
require_relative "openai/resources/fine_tuning/alpha/graders"
require_relative "openai/resources/fine_tuning/checkpoints"
require_relative "openai/resources/fine_tuning/checkpoints/permissions"
require_relative "openai/resources/fine_tuning/jobs"
require_relative "openai/resources/fine_tuning/jobs/checkpoints"
require_relative "openai/resources/fine_tuning/methods"
require_relative "openai/resources/graders"
require_relative "openai/resources/graders/grader_models"
require_relative "openai/resources/images"
require_relative "openai/resources/models"
require_relative "openai/resources/moderations"
require_relative "openai/resources/responses"
require_relative "openai/resources/responses/input_items"
require_relative "openai/resources/uploads"
require_relative "openai/resources/uploads/parts"
require_relative "openai/resources/vector_stores"
require_relative "openai/resources/vector_stores/file_batches"
require_relative "openai/resources/vector_stores/files"
require_relative "openai/resources/webhooks"
require_relative "openai/helpers/streaming/events"
require_relative "openai/helpers/streaming/response_stream"
require_relative "openai/streaming"
