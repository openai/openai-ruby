# frozen_string_literal: true

module OpenAI
  [OpenAI::Internal::Type::BaseModel, *OpenAI::Internal::Type::BaseModel.subclasses].each do |cls|
    cls.define_sorbet_constant!(:OrHash) { T.type_alias { T.any(cls, OpenAI::Internal::AnyHash) } }
  end

  [
    *OpenAI::Internal::Type::Enum.included_modules,
    *OpenAI::Internal::Type::Union.included_modules
  ].each do |cls|
    cls.constants.each do |name|
      case cls.const_get(name)
      in true | false
        cls.define_sorbet_constant!(:TaggedBoolean) { T.type_alias { T.all(T::Boolean, cls) } }
        cls.define_sorbet_constant!(:OrBoolean) { T.type_alias { T::Boolean } }
      in Integer
        cls.define_sorbet_constant!(:TaggedInteger) { T.type_alias { T.all(Integer, cls) } }
        cls.define_sorbet_constant!(:OrInteger) { T.type_alias { Integer } }
      in Float
        cls.define_sorbet_constant!(:TaggedFloat) { T.type_alias { T.all(Float, cls) } }
        cls.define_sorbet_constant!(:OrFloat) { T.type_alias { Float } }
      in Symbol
        cls.define_sorbet_constant!(:TaggedSymbol) { T.type_alias { T.all(Symbol, cls) } }
        cls.define_sorbet_constant!(:OrSymbol) { T.type_alias { T.any(Symbol, String) } }
      else
      end
    end
  end

  AllModels = OpenAI::Models::AllModels

  Audio = OpenAI::Models::Audio

  AudioModel = OpenAI::Models::AudioModel

  AudioResponseFormat = OpenAI::Models::AudioResponseFormat

  AutoFileChunkingStrategyParam = OpenAI::Models::AutoFileChunkingStrategyParam

  Batch = OpenAI::Models::Batch

  BatchCancelParams = OpenAI::Models::BatchCancelParams

  BatchCreateParams = OpenAI::Models::BatchCreateParams

  BatchError = OpenAI::Models::BatchError

  BatchListParams = OpenAI::Models::BatchListParams

  BatchRequestCounts = OpenAI::Models::BatchRequestCounts

  BatchRetrieveParams = OpenAI::Models::BatchRetrieveParams

  Beta = OpenAI::Models::Beta

  Chat = OpenAI::Models::Chat

  ChatModel = OpenAI::Models::ChatModel

  ComparisonFilter = OpenAI::Models::ComparisonFilter

  Completion = OpenAI::Models::Completion

  CompletionChoice = OpenAI::Models::CompletionChoice

  CompletionCreateParams = OpenAI::Models::CompletionCreateParams

  CompletionUsage = OpenAI::Models::CompletionUsage

  CompoundFilter = OpenAI::Models::CompoundFilter

  CreateEmbeddingResponse = OpenAI::Models::CreateEmbeddingResponse

  Embedding = OpenAI::Models::Embedding

  EmbeddingCreateParams = OpenAI::Models::EmbeddingCreateParams

  EmbeddingModel = OpenAI::Models::EmbeddingModel

  ErrorObject = OpenAI::Models::ErrorObject

  EvalCreateParams = OpenAI::Models::EvalCreateParams

  EvalCustomDataSourceConfig = OpenAI::Models::EvalCustomDataSourceConfig

  EvalDeleteParams = OpenAI::Models::EvalDeleteParams

  EvalListParams = OpenAI::Models::EvalListParams

  EvalRetrieveParams = OpenAI::Models::EvalRetrieveParams

  Evals = OpenAI::Models::Evals

  EvalStoredCompletionsDataSourceConfig = OpenAI::Models::EvalStoredCompletionsDataSourceConfig

  EvalUpdateParams = OpenAI::Models::EvalUpdateParams

  FileChunkingStrategy = OpenAI::Models::FileChunkingStrategy

  FileChunkingStrategyParam = OpenAI::Models::FileChunkingStrategyParam

  FileContent = OpenAI::Models::FileContent

  FileContentParams = OpenAI::Models::FileContentParams

  FileCreateParams = OpenAI::Models::FileCreateParams

  FileDeleted = OpenAI::Models::FileDeleted

  FileDeleteParams = OpenAI::Models::FileDeleteParams

  FileListParams = OpenAI::Models::FileListParams

  FileObject = OpenAI::Models::FileObject

  FilePurpose = OpenAI::Models::FilePurpose

  FileRetrieveParams = OpenAI::Models::FileRetrieveParams

  FineTuning = OpenAI::Models::FineTuning

  FunctionDefinition = OpenAI::Models::FunctionDefinition

  # @type [OpenAI::Internal::Type::Converter]
  FunctionParameters = OpenAI::Models::FunctionParameters

  Graders = OpenAI::Models::Graders

  Image = OpenAI::Models::Image

  ImageCreateVariationParams = OpenAI::Models::ImageCreateVariationParams

  ImageEditParams = OpenAI::Models::ImageEditParams

  ImageGenerateParams = OpenAI::Models::ImageGenerateParams

  ImageModel = OpenAI::Models::ImageModel

  ImagesResponse = OpenAI::Models::ImagesResponse

  # @type [OpenAI::Internal::Type::Converter]
  Metadata = OpenAI::Models::Metadata

  Model = OpenAI::Models::Model

  ModelDeleted = OpenAI::Models::ModelDeleted

  ModelDeleteParams = OpenAI::Models::ModelDeleteParams

  ModelListParams = OpenAI::Models::ModelListParams

  ModelRetrieveParams = OpenAI::Models::ModelRetrieveParams

  Moderation = OpenAI::Models::Moderation

  ModerationCreateParams = OpenAI::Models::ModerationCreateParams

  ModerationImageURLInput = OpenAI::Models::ModerationImageURLInput

  ModerationModel = OpenAI::Models::ModerationModel

  ModerationMultiModalInput = OpenAI::Models::ModerationMultiModalInput

  ModerationTextInput = OpenAI::Models::ModerationTextInput

  OtherFileChunkingStrategyObject = OpenAI::Models::OtherFileChunkingStrategyObject

  Reasoning = OpenAI::Models::Reasoning

  ReasoningEffort = OpenAI::Models::ReasoningEffort

  ResponseFormatJSONObject = OpenAI::Models::ResponseFormatJSONObject

  ResponseFormatJSONSchema = OpenAI::Models::ResponseFormatJSONSchema

  ResponseFormatText = OpenAI::Models::ResponseFormatText

  Responses = OpenAI::Models::Responses

  ResponsesModel = OpenAI::Models::ResponsesModel

  StaticFileChunkingStrategy = OpenAI::Models::StaticFileChunkingStrategy

  StaticFileChunkingStrategyObject = OpenAI::Models::StaticFileChunkingStrategyObject

  StaticFileChunkingStrategyObjectParam = OpenAI::Models::StaticFileChunkingStrategyObjectParam

  Upload = OpenAI::Models::Upload

  UploadCancelParams = OpenAI::Models::UploadCancelParams

  UploadCompleteParams = OpenAI::Models::UploadCompleteParams

  UploadCreateParams = OpenAI::Models::UploadCreateParams

  Uploads = OpenAI::Models::Uploads

  VectorStore = OpenAI::Models::VectorStore

  VectorStoreCreateParams = OpenAI::Models::VectorStoreCreateParams

  VectorStoreDeleted = OpenAI::Models::VectorStoreDeleted

  VectorStoreDeleteParams = OpenAI::Models::VectorStoreDeleteParams

  VectorStoreListParams = OpenAI::Models::VectorStoreListParams

  VectorStoreRetrieveParams = OpenAI::Models::VectorStoreRetrieveParams

  VectorStores = OpenAI::Models::VectorStores

  VectorStoreSearchParams = OpenAI::Models::VectorStoreSearchParams

  VectorStoreUpdateParams = OpenAI::Models::VectorStoreUpdateParams
end
