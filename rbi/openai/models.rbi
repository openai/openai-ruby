# typed: strong

module OpenAI
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

  ContainerCreateParams = OpenAI::Models::ContainerCreateParams

  ContainerDeleteParams = OpenAI::Models::ContainerDeleteParams

  ContainerListParams = OpenAI::Models::ContainerListParams

  ContainerRetrieveParams = OpenAI::Models::ContainerRetrieveParams

  Containers = OpenAI::Models::Containers

  CreateEmbeddingResponse = OpenAI::Models::CreateEmbeddingResponse

  CustomToolInputFormat = OpenAI::Models::CustomToolInputFormat

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

  EvalStoredCompletionsDataSourceConfig =
    OpenAI::Models::EvalStoredCompletionsDataSourceConfig

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

  FunctionParameters =
    T.let(OpenAI::Models::FunctionParameters, OpenAI::Internal::Type::Converter)

  Graders = OpenAI::Models::Graders

  Image = OpenAI::Models::Image

  ImageCreateVariationParams = OpenAI::Models::ImageCreateVariationParams

  ImageEditCompletedEvent = OpenAI::Models::ImageEditCompletedEvent

  ImageEditParams = OpenAI::Models::ImageEditParams

  ImageEditPartialImageEvent = OpenAI::Models::ImageEditPartialImageEvent

  ImageEditStreamEvent = OpenAI::Models::ImageEditStreamEvent

  ImageGenCompletedEvent = OpenAI::Models::ImageGenCompletedEvent

  ImageGenerateParams = OpenAI::Models::ImageGenerateParams

  ImageGenPartialImageEvent = OpenAI::Models::ImageGenPartialImageEvent

  ImageGenStreamEvent = OpenAI::Models::ImageGenStreamEvent

  ImageModel = OpenAI::Models::ImageModel

  ImagesResponse = OpenAI::Models::ImagesResponse

  Metadata = T.let(OpenAI::Models::Metadata, OpenAI::Internal::Type::Converter)

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

  OtherFileChunkingStrategyObject =
    OpenAI::Models::OtherFileChunkingStrategyObject

  Reasoning = OpenAI::Models::Reasoning

  ReasoningEffort = OpenAI::Models::ReasoningEffort

  ResponseFormatJSONObject = OpenAI::Models::ResponseFormatJSONObject

  ResponseFormatJSONSchema = OpenAI::Models::ResponseFormatJSONSchema

  ResponseFormatText = OpenAI::Models::ResponseFormatText

  ResponseFormatTextGrammar = OpenAI::Models::ResponseFormatTextGrammar

  ResponseFormatTextPython = OpenAI::Models::ResponseFormatTextPython

  Responses = OpenAI::Models::Responses

  ResponsesModel = OpenAI::Models::ResponsesModel

  StaticFileChunkingStrategy = OpenAI::Models::StaticFileChunkingStrategy

  StaticFileChunkingStrategyObject =
    OpenAI::Models::StaticFileChunkingStrategyObject

  StaticFileChunkingStrategyObjectParam =
    OpenAI::Models::StaticFileChunkingStrategyObjectParam

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

  Webhooks = OpenAI::Models::Webhooks
end
