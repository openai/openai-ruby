# typed: strong

module OpenAI
  module Models
    class Video < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(OpenAI::Video, OpenAI::Internal::AnyHash) }

      # Unique identifier for the video job.
      sig { returns(String) }
      attr_accessor :id

      # Unix timestamp (seconds) for when the job completed, if finished.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :completed_at

      # Unix timestamp (seconds) for when the job was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Error payload that explains why generation failed, if applicable.
      sig { returns(T.nilable(OpenAI::VideoCreateError)) }
      attr_reader :error

      sig { params(error: T.nilable(OpenAI::VideoCreateError::OrHash)).void }
      attr_writer :error

      # Unix timestamp (seconds) for when the downloadable assets expire, if set.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :expires_at

      # The video generation model that produced the job.
      sig { returns(OpenAI::VideoModel::TaggedSymbol) }
      attr_accessor :model

      # The object type, which is always `video`.
      sig { returns(Symbol) }
      attr_accessor :object

      # Approximate completion percentage for the generation task.
      sig { returns(Integer) }
      attr_accessor :progress

      # The prompt that was used to generate the video.
      sig { returns(T.nilable(String)) }
      attr_accessor :prompt

      # Identifier of the source video if this video is a remix.
      sig { returns(T.nilable(String)) }
      attr_accessor :remixed_from_video_id

      # Duration of the generated clip in seconds.
      sig { returns(OpenAI::VideoSeconds::TaggedSymbol) }
      attr_accessor :seconds

      # The resolution of the generated video.
      sig { returns(OpenAI::VideoSize::TaggedSymbol) }
      attr_accessor :size

      # Current lifecycle status of the video job.
      sig { returns(OpenAI::Video::Status::TaggedSymbol) }
      attr_accessor :status

      # Structured information describing a generated video job.
      sig do
        params(
          id: String,
          completed_at: T.nilable(Integer),
          created_at: Integer,
          error: T.nilable(OpenAI::VideoCreateError::OrHash),
          expires_at: T.nilable(Integer),
          model: OpenAI::VideoModel::OrSymbol,
          progress: Integer,
          prompt: T.nilable(String),
          remixed_from_video_id: T.nilable(String),
          seconds: OpenAI::VideoSeconds::OrSymbol,
          size: OpenAI::VideoSize::OrSymbol,
          status: OpenAI::Video::Status::OrSymbol,
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Unique identifier for the video job.
        id:,
        # Unix timestamp (seconds) for when the job completed, if finished.
        completed_at:,
        # Unix timestamp (seconds) for when the job was created.
        created_at:,
        # Error payload that explains why generation failed, if applicable.
        error:,
        # Unix timestamp (seconds) for when the downloadable assets expire, if set.
        expires_at:,
        # The video generation model that produced the job.
        model:,
        # Approximate completion percentage for the generation task.
        progress:,
        # The prompt that was used to generate the video.
        prompt:,
        # Identifier of the source video if this video is a remix.
        remixed_from_video_id:,
        # Duration of the generated clip in seconds.
        seconds:,
        # The resolution of the generated video.
        size:,
        # Current lifecycle status of the video job.
        status:,
        # The object type, which is always `video`.
        object: :video
      )
      end

      sig do
        override.returns(
          {
            id: String,
            completed_at: T.nilable(Integer),
            created_at: Integer,
            error: T.nilable(OpenAI::VideoCreateError),
            expires_at: T.nilable(Integer),
            model: OpenAI::VideoModel::TaggedSymbol,
            object: Symbol,
            progress: Integer,
            prompt: T.nilable(String),
            remixed_from_video_id: T.nilable(String),
            seconds: OpenAI::VideoSeconds::TaggedSymbol,
            size: OpenAI::VideoSize::TaggedSymbol,
            status: OpenAI::Video::Status::TaggedSymbol
          }
        )
      end
      def to_hash
      end

      # Current lifecycle status of the video job.
      module Status
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Video::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        QUEUED = T.let(:queued, OpenAI::Video::Status::TaggedSymbol)
        IN_PROGRESS = T.let(:in_progress, OpenAI::Video::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Video::Status::TaggedSymbol)
        FAILED = T.let(:failed, OpenAI::Video::Status::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Video::Status::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end
