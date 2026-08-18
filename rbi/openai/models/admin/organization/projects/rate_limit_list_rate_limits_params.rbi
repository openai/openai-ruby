# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class RateLimitListRateLimitsParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::RateLimitListRateLimitsParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # A cursor for use in pagination. `before` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # beginning with obj_foo, your subsequent call can include before=obj_foo in order
            # to fetch the previous page of the list.
            sig { returns(T.nilable(String)) }
            attr_reader :before

            sig { params(before: String).void }
            attr_writer :before

            # A limit on the number of objects to be returned. The default is 100.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            sig do
              params(
                project_id: String,
                after: String,
                before: String,
                limit: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # A cursor for use in pagination. `after` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # ending with obj_foo, your subsequent call can include after=obj_foo in order to
              # fetch the next page of the list.
              after: nil,
              # A cursor for use in pagination. `before` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # beginning with obj_foo, your subsequent call can include before=obj_foo in order
              # to fetch the previous page of the list.
              before: nil,
              # A limit on the number of objects to be returned. The default is 100.
              limit: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  after: String,
                  before: String,
                  limit: Integer,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
