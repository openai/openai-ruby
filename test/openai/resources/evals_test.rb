# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::EvalsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.evals.create(
        data_source_config: {
          item_schema: {
            "0": "bar",
            "1": "bar",
            "2": "bar",
            "3": "bar",
            "4": "bar",
            "5": "bar",
            "6": "bar",
            "7": "bar",
            "8": "bar",
            "9": "bar",
            "10": "bar",
            "11": "bar",
            "12": "bar",
            "13": "bar",
            "14": "bar",
            "15": "bar",
            "16": "bar",
            "17": "bar",
            "18": "bar",
            "19": "bar",
            "20": "bar",
            "21": "bar",
            "22": "bar",
            "23": "bar",
            "24": "bar",
            "25": "bar",
            "26": "bar",
            "27": "bar",
            "28": "bar",
            "29": "bar",
            "30": "bar",
            "31": "bar",
            "32": "bar",
            "33": "bar",
            "34": "bar",
            "35": "bar",
            "36": "bar",
            "37": "bar",
            "38": "bar",
            "39": "bar",
            "40": "bar",
            "41": "bar",
            "42": "bar",
            "43": "bar",
            "44": "bar",
            "45": "bar",
            "46": "bar",
            "47": "bar",
            "48": "bar",
            "49": "bar",
            "50": "bar",
            "51": "bar",
            "52": "bar",
            "53": "bar",
            "54": "bar",
            "55": "bar",
            "56": "bar",
            "57": "bar",
            "58": "bar",
            "59": "bar",
            "60": "bar",
            "61": "bar",
            "62": "bar",
            "63": "bar",
            "64": "bar",
            "65": "bar",
            "66": "bar",
            "67": "bar",
            "68": "bar",
            "69": "bar",
            "70": "bar",
            "71": "bar",
            "72": "bar",
            "73": "bar",
            "74": "bar",
            "75": "bar",
            "76": "bar",
            "77": "bar",
            "78": "bar",
            "79": "bar",
            "80": "bar",
            "81": "bar",
            "82": "bar",
            "83": "bar",
            "84": "bar",
            "85": "bar",
            "86": "bar",
            "87": "bar",
            "88": "bar",
            "89": "bar",
            "90": "bar",
            "91": "bar",
            "92": "bar",
            "93": "bar",
            "94": "bar",
            "95": "bar",
            "96": "bar",
            "97": "bar",
            "98": "bar",
            "99": "bar",
            "100": "bar",
            "101": "bar",
            "102": "bar",
            "103": "bar",
            "104": "bar",
            "105": "bar",
            "106": "bar",
            "107": "bar",
            "108": "bar",
            "109": "bar",
            "110": "bar",
            "111": "bar",
            "112": "bar",
            "113": "bar",
            "114": "bar",
            "115": "bar",
            "116": "bar",
            "117": "bar",
            "118": "bar",
            "119": "bar",
            "120": "bar",
            "121": "bar",
            "122": "bar",
            "123": "bar",
            "124": "bar",
            "125": "bar",
            "126": "bar",
            "127": "bar",
            "128": "bar",
            "129": "bar",
            "130": "bar",
            "131": "bar",
            "132": "bar",
            "133": "bar",
            "134": "bar",
            "135": "bar",
            "136": "bar",
            "137": "bar",
            "138": "bar",
            "139": "bar"
          },
          type: :custom
        },
        testing_criteria: [
          {
            input: [{content: "content", role: "role"}],
            labels: ["string"],
            model: "model",
            name: "name",
            passing_labels: ["string"],
            type: :label_model
          }
        ]
      )

    assert_pattern do
      response => OpenAI::Models::EvalCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalCreateResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        share_with_openai: OpenAI::Internal::Type::Boolean,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalCreateResponse::TestingCriterion])
      }
    end
  end

  def test_retrieve
    response = @openai.evals.retrieve("eval_id")

    assert_pattern do
      response => OpenAI::Models::EvalRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalRetrieveResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        share_with_openai: OpenAI::Internal::Type::Boolean,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalRetrieveResponse::TestingCriterion])
      }
    end
  end

  def test_update
    response = @openai.evals.update("eval_id")

    assert_pattern do
      response => OpenAI::Models::EvalUpdateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalUpdateResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        share_with_openai: OpenAI::Internal::Type::Boolean,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalUpdateResponse::TestingCriterion])
      }
    end
  end

  def test_list
    response = @openai.evals.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::EvalListResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalListResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        share_with_openai: OpenAI::Internal::Type::Boolean,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalListResponse::TestingCriterion])
      }
    end
  end

  def test_delete
    response = @openai.evals.delete("eval_id")

    assert_pattern do
      response => OpenAI::Models::EvalDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        eval_id: String,
        object: String
      }
    end
  end
end
