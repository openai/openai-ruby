# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#create
    class Video < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   Unique identifier for the video job.
      #
      #   @return [String]
      required :id, String

      # @!attribute completed_at
      #   Unix timestamp (seconds) for when the job completed, if finished.
      #
      #   @return [Integer, nil]
      required :completed_at, Integer, nil?: true

      # @!attribute created_at
      #   Unix timestamp (seconds) for when the job was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute error
      #   Error payload that explains why generation failed, if applicable.
      #
      #   @return [OpenAI::Models::VideoCreateError, nil]
      required :error, -> { OpenAI::VideoCreateError }, nil?: true

      # @!attribute expires_at
      #   Unix timestamp (seconds) for when the downloadable assets expire, if set.
      #
      #   @return [Integer, nil]
      required :expires_at, Integer, nil?: true

      # @!attribute model
      #   The video generation model that produced the job.
      #
      #   @return [Symbol, OpenAI::Models::VideoModel]
      required :model, enum: -> { OpenAI::VideoModel }

      # @!attribute object
      #   The object type, which is always `video`.
      #
      #   @return [Symbol, :video]
      required :object, const: :video

      # @!attribute progress
      #   Approximate completion percentage for the generation task.
      #
      #   @return [Integer]
      required :progress, Integer

      # @!attribute prompt
      #   The prompt that was used to generate the video.
      #
      #   @return [String, nil]
      required :prompt, String, nil?: true

      # @!attribute remixed_from_video_id
      #   Identifier of the source video if this video is a remix.
      #
      #   @return [String, nil]
      required :remixed_from_video_id, String, nil?: true

      # @!attribute seconds
      #   Duration of the generated clip in seconds.
      #
      #   @return [Symbol, OpenAI::Models::VideoSeconds]
      required :seconds, enum: -> { OpenAI::VideoSeconds }

      # @!attribute size
      #   The resolution of the generated video.
      #
      #   @return [Symbol, OpenAI::Models::VideoSize]
      required :size, enum: -> { OpenAI::VideoSize }

      # @!attribute status
      #   Current lifecycle status of the video job.
      #
      #   @return [Symbol, OpenAI::Models::Video::Status]
      required :status, enum: -> { OpenAI::Video::Status }

      # @!method initialize(id:, completed_at:, created_at:, error:, expires_at:, model:, progress:, prompt:, remixed_from_video_id:, seconds:, size:, status:, object: :video)
      #   Structured information describing a generated video job.
      #
      #   @param id [String] Unique identifier for the video job.
      #
      #   @param completed_at [Integer, nil] Unix timestamp (seconds) for when the job completed, if finished.
      #
      #   @param created_at [Integer] Unix timestamp (seconds) for when the job was created.
      #
      #   @param error [OpenAI::Models::VideoCreateError, nil] Error payload that explains why generation failed, if applicable.
      #
      #   @param expires_at [Integer, nil] Unix timestamp (seconds) for when the downloadable assets expire, if set.
      #
      #   @param model [Symbol, OpenAI::Models::VideoModel] The video generation model that produced the job.
      #
      #   @param progress [Integer] Approximate completion percentage for the generation task.
      #
      #   @param prompt [String, nil] The prompt that was used to generate the video.
      #
      #   @param remixed_from_video_id [String, nil] Identifier of the source video if this video is a remix.
      #
      #   @param seconds [Symbol, OpenAI::Models::VideoSeconds] Duration of the generated clip in seconds.
      #
      #   @param size [Symbol, OpenAI::Models::VideoSize] The resolution of the generated video.
      #
      #   @param status [Symbol, OpenAI::Models::Video::Status] Current lifecycle status of the video job.
      #
      #   @param object [Symbol, :video] The object type, which is always `video`.

      # Current lifecycle status of the video job.
      #
      # @see OpenAI::Models::Video#status
      module Status
        extend OpenAI::Internal::Type::Enum

        QUEUED = :queued
        IN_PROGRESS = :in_progress
        COMPLETED = :completed
        FAILED = :failed

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
