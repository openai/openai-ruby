# typed: strong

module OpenAI
  module Models
    class Moderation < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # A list of the categories, and whether they are flagged or not.
      sig { returns(OpenAI::Moderation::Categories) }
      attr_reader :categories

      sig { params(categories: OpenAI::Moderation::Categories::OrHash).void }
      attr_writer :categories

      # A list of the categories along with the input type(s) that the score applies to.
      sig { returns(OpenAI::Moderation::CategoryAppliedInputTypes) }
      attr_reader :category_applied_input_types

      sig do
        params(
          category_applied_input_types:
            OpenAI::Moderation::CategoryAppliedInputTypes::OrHash
        ).void
      end
      attr_writer :category_applied_input_types

      # A list of the categories along with their scores as predicted by model.
      sig { returns(OpenAI::Moderation::CategoryScores) }
      attr_reader :category_scores

      sig do
        params(category_scores: OpenAI::Moderation::CategoryScores::OrHash).void
      end
      attr_writer :category_scores

      # Whether any of the below categories are flagged.
      sig { returns(T::Boolean) }
      attr_accessor :flagged

      sig do
        params(
          categories: OpenAI::Moderation::Categories::OrHash,
          category_applied_input_types:
            OpenAI::Moderation::CategoryAppliedInputTypes::OrHash,
          category_scores: OpenAI::Moderation::CategoryScores::OrHash,
          flagged: T::Boolean
        ).returns(T.attached_class)
      end
      def self.new(
        # A list of the categories, and whether they are flagged or not.
        categories:,
        # A list of the categories along with the input type(s) that the score applies to.
        category_applied_input_types:,
        # A list of the categories along with their scores as predicted by model.
        category_scores:,
        # Whether any of the below categories are flagged.
        flagged:
      )
      end

      sig do
        override.returns(
          {
            categories: OpenAI::Moderation::Categories,
            category_applied_input_types:
              OpenAI::Moderation::CategoryAppliedInputTypes,
            category_scores: OpenAI::Moderation::CategoryScores,
            flagged: T::Boolean
          }
        )
      end
      def to_hash
      end

      class Categories < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Content that expresses, incites, or promotes harassing language towards any
        # target.
        sig { returns(T::Boolean) }
        attr_accessor :harassment

        # Harassment content that also includes violence or serious harm towards any
        # target.
        sig { returns(T::Boolean) }
        attr_accessor :harassment_threatening

        # Content that expresses, incites, or promotes hate based on race, gender,
        # ethnicity, religion, nationality, sexual orientation, disability status, or
        # caste. Hateful content aimed at non-protected groups (e.g., chess players) is
        # harassment.
        sig { returns(T::Boolean) }
        attr_accessor :hate

        # Hateful content that also includes violence or serious harm towards the targeted
        # group based on race, gender, ethnicity, religion, nationality, sexual
        # orientation, disability status, or caste.
        sig { returns(T::Boolean) }
        attr_accessor :hate_threatening

        # Content that includes instructions or advice that facilitate the planning or
        # execution of wrongdoing, or that gives advice or instruction on how to commit
        # illicit acts. For example, "how to shoplift" would fit this category.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :illicit

        # Content that includes instructions or advice that facilitate the planning or
        # execution of wrongdoing that also includes violence, or that gives advice or
        # instruction on the procurement of any weapon.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :illicit_violent

        # Content that promotes, encourages, or depicts acts of self-harm, such as
        # suicide, cutting, and eating disorders.
        sig { returns(T::Boolean) }
        attr_accessor :self_harm

        # Content that encourages performing acts of self-harm, such as suicide, cutting,
        # and eating disorders, or that gives instructions or advice on how to commit such
        # acts.
        sig { returns(T::Boolean) }
        attr_accessor :self_harm_instructions

        # Content where the speaker expresses that they are engaging or intend to engage
        # in acts of self-harm, such as suicide, cutting, and eating disorders.
        sig { returns(T::Boolean) }
        attr_accessor :self_harm_intent

        # Content meant to arouse sexual excitement, such as the description of sexual
        # activity, or that promotes sexual services (excluding sex education and
        # wellness).
        sig { returns(T::Boolean) }
        attr_accessor :sexual

        # Sexual content that includes an individual who is under 18 years old.
        sig { returns(T::Boolean) }
        attr_accessor :sexual_minors

        # Content that depicts death, violence, or physical injury.
        sig { returns(T::Boolean) }
        attr_accessor :violence

        # Content that depicts death, violence, or physical injury in graphic detail.
        sig { returns(T::Boolean) }
        attr_accessor :violence_graphic

        # A list of the categories, and whether they are flagged or not.
        sig do
          params(
            harassment: T::Boolean,
            harassment_threatening: T::Boolean,
            hate: T::Boolean,
            hate_threatening: T::Boolean,
            illicit: T.nilable(T::Boolean),
            illicit_violent: T.nilable(T::Boolean),
            self_harm: T::Boolean,
            self_harm_instructions: T::Boolean,
            self_harm_intent: T::Boolean,
            sexual: T::Boolean,
            sexual_minors: T::Boolean,
            violence: T::Boolean,
            violence_graphic: T::Boolean
          ).returns(T.attached_class)
        end
        def self.new(
          # Content that expresses, incites, or promotes harassing language towards any
          # target.
          harassment:,
          # Harassment content that also includes violence or serious harm towards any
          # target.
          harassment_threatening:,
          # Content that expresses, incites, or promotes hate based on race, gender,
          # ethnicity, religion, nationality, sexual orientation, disability status, or
          # caste. Hateful content aimed at non-protected groups (e.g., chess players) is
          # harassment.
          hate:,
          # Hateful content that also includes violence or serious harm towards the targeted
          # group based on race, gender, ethnicity, religion, nationality, sexual
          # orientation, disability status, or caste.
          hate_threatening:,
          # Content that includes instructions or advice that facilitate the planning or
          # execution of wrongdoing, or that gives advice or instruction on how to commit
          # illicit acts. For example, "how to shoplift" would fit this category.
          illicit:,
          # Content that includes instructions or advice that facilitate the planning or
          # execution of wrongdoing that also includes violence, or that gives advice or
          # instruction on the procurement of any weapon.
          illicit_violent:,
          # Content that promotes, encourages, or depicts acts of self-harm, such as
          # suicide, cutting, and eating disorders.
          self_harm:,
          # Content that encourages performing acts of self-harm, such as suicide, cutting,
          # and eating disorders, or that gives instructions or advice on how to commit such
          # acts.
          self_harm_instructions:,
          # Content where the speaker expresses that they are engaging or intend to engage
          # in acts of self-harm, such as suicide, cutting, and eating disorders.
          self_harm_intent:,
          # Content meant to arouse sexual excitement, such as the description of sexual
          # activity, or that promotes sexual services (excluding sex education and
          # wellness).
          sexual:,
          # Sexual content that includes an individual who is under 18 years old.
          sexual_minors:,
          # Content that depicts death, violence, or physical injury.
          violence:,
          # Content that depicts death, violence, or physical injury in graphic detail.
          violence_graphic:
        )
        end

        sig do
          override.returns(
            {
              harassment: T::Boolean,
              harassment_threatening: T::Boolean,
              hate: T::Boolean,
              hate_threatening: T::Boolean,
              illicit: T.nilable(T::Boolean),
              illicit_violent: T.nilable(T::Boolean),
              self_harm: T::Boolean,
              self_harm_instructions: T::Boolean,
              self_harm_intent: T::Boolean,
              sexual: T::Boolean,
              sexual_minors: T::Boolean,
              violence: T::Boolean,
              violence_graphic: T::Boolean
            }
          )
        end
        def to_hash
        end
      end

      class CategoryAppliedInputTypes < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The applied input type(s) for the category 'harassment'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol
            ]
          )
        end
        attr_accessor :harassment

        # The applied input type(s) for the category 'harassment/threatening'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol
            ]
          )
        end
        attr_accessor :harassment_threatening

        # The applied input type(s) for the category 'hate'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol
            ]
          )
        end
        attr_accessor :hate

        # The applied input type(s) for the category 'hate/threatening'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol
            ]
          )
        end
        attr_accessor :hate_threatening

        # The applied input type(s) for the category 'illicit'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol
            ]
          )
        end
        attr_accessor :illicit

        # The applied input type(s) for the category 'illicit/violent'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol
            ]
          )
        end
        attr_accessor :illicit_violent

        # The applied input type(s) for the category 'self-harm'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol
            ]
          )
        end
        attr_accessor :self_harm

        # The applied input type(s) for the category 'self-harm/instructions'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol
            ]
          )
        end
        attr_accessor :self_harm_instructions

        # The applied input type(s) for the category 'self-harm/intent'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol
            ]
          )
        end
        attr_accessor :self_harm_intent

        # The applied input type(s) for the category 'sexual'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol
            ]
          )
        end
        attr_accessor :sexual

        # The applied input type(s) for the category 'sexual/minors'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol
            ]
          )
        end
        attr_accessor :sexual_minors

        # The applied input type(s) for the category 'violence'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol
            ]
          )
        end
        attr_accessor :violence

        # The applied input type(s) for the category 'violence/graphic'.
        sig do
          returns(
            T::Array[
              OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol
            ]
          )
        end
        attr_accessor :violence_graphic

        # A list of the categories along with the input type(s) that the score applies to.
        sig do
          params(
            harassment:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Harassment::OrSymbol
              ],
            harassment_threatening:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::OrSymbol
              ],
            hate:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Hate::OrSymbol
              ],
            hate_threatening:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening::OrSymbol
              ],
            illicit:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Illicit::OrSymbol
              ],
            illicit_violent:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent::OrSymbol
              ],
            self_harm:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm::OrSymbol
              ],
            self_harm_instructions:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::OrSymbol
              ],
            self_harm_intent:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::OrSymbol
              ],
            sexual:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Sexual::OrSymbol
              ],
            sexual_minors:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor::OrSymbol
              ],
            violence:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Violence::OrSymbol
              ],
            violence_graphic:
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::OrSymbol
              ]
          ).returns(T.attached_class)
        end
        def self.new(
          # The applied input type(s) for the category 'harassment'.
          harassment:,
          # The applied input type(s) for the category 'harassment/threatening'.
          harassment_threatening:,
          # The applied input type(s) for the category 'hate'.
          hate:,
          # The applied input type(s) for the category 'hate/threatening'.
          hate_threatening:,
          # The applied input type(s) for the category 'illicit'.
          illicit:,
          # The applied input type(s) for the category 'illicit/violent'.
          illicit_violent:,
          # The applied input type(s) for the category 'self-harm'.
          self_harm:,
          # The applied input type(s) for the category 'self-harm/instructions'.
          self_harm_instructions:,
          # The applied input type(s) for the category 'self-harm/intent'.
          self_harm_intent:,
          # The applied input type(s) for the category 'sexual'.
          sexual:,
          # The applied input type(s) for the category 'sexual/minors'.
          sexual_minors:,
          # The applied input type(s) for the category 'violence'.
          violence:,
          # The applied input type(s) for the category 'violence/graphic'.
          violence_graphic:
        )
        end

        sig do
          override.returns(
            {
              harassment:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol
                ],
              harassment_threatening:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol
                ],
              hate:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol
                ],
              hate_threatening:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol
                ],
              illicit:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol
                ],
              illicit_violent:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol
                ],
              self_harm:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol
                ],
              self_harm_instructions:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol
                ],
              self_harm_intent:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol
                ],
              sexual:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol
                ],
              sexual_minors:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol
                ],
              violence:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol
                ],
              violence_graphic:
                T::Array[
                  OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol
                ]
            }
          )
        end
        def to_hash
        end

        module Harassment
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::Harassment
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Harassment::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module HarassmentThreatening
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::HarassmentThreatening::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Hate
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Moderation::CategoryAppliedInputTypes::Hate)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Hate::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module HateThreatening
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::HateThreatening::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Illicit
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::Illicit
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Illicit::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module IllicitViolent
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::IllicitViolent::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module SelfHarm
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol
            )
          IMAGE =
            T.let(
              :image,
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarm::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module SelfHarmInstruction
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol
            )
          IMAGE =
            T.let(
              :image,
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmInstruction::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module SelfHarmIntent
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol
            )
          IMAGE =
            T.let(
              :image,
              OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SelfHarmIntent::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Sexual
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::Sexual
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol
            )
          IMAGE =
            T.let(
              :image,
              OpenAI::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Sexual::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module SexualMinor
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::SexualMinor::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Violence
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::Violence
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol
            )
          IMAGE =
            T.let(
              :image,
              OpenAI::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::Violence::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module ViolenceGraphic
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol
            )
          IMAGE =
            T.let(
              :image,
              OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Moderation::CategoryAppliedInputTypes::ViolenceGraphic::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end

      class CategoryScores < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The score for the category 'harassment'.
        sig { returns(Float) }
        attr_accessor :harassment

        # The score for the category 'harassment/threatening'.
        sig { returns(Float) }
        attr_accessor :harassment_threatening

        # The score for the category 'hate'.
        sig { returns(Float) }
        attr_accessor :hate

        # The score for the category 'hate/threatening'.
        sig { returns(Float) }
        attr_accessor :hate_threatening

        # The score for the category 'illicit'.
        sig { returns(Float) }
        attr_accessor :illicit

        # The score for the category 'illicit/violent'.
        sig { returns(Float) }
        attr_accessor :illicit_violent

        # The score for the category 'self-harm'.
        sig { returns(Float) }
        attr_accessor :self_harm

        # The score for the category 'self-harm/instructions'.
        sig { returns(Float) }
        attr_accessor :self_harm_instructions

        # The score for the category 'self-harm/intent'.
        sig { returns(Float) }
        attr_accessor :self_harm_intent

        # The score for the category 'sexual'.
        sig { returns(Float) }
        attr_accessor :sexual

        # The score for the category 'sexual/minors'.
        sig { returns(Float) }
        attr_accessor :sexual_minors

        # The score for the category 'violence'.
        sig { returns(Float) }
        attr_accessor :violence

        # The score for the category 'violence/graphic'.
        sig { returns(Float) }
        attr_accessor :violence_graphic

        # A list of the categories along with their scores as predicted by model.
        sig do
          params(
            harassment: Float,
            harassment_threatening: Float,
            hate: Float,
            hate_threatening: Float,
            illicit: Float,
            illicit_violent: Float,
            self_harm: Float,
            self_harm_instructions: Float,
            self_harm_intent: Float,
            sexual: Float,
            sexual_minors: Float,
            violence: Float,
            violence_graphic: Float
          ).returns(T.attached_class)
        end
        def self.new(
          # The score for the category 'harassment'.
          harassment:,
          # The score for the category 'harassment/threatening'.
          harassment_threatening:,
          # The score for the category 'hate'.
          hate:,
          # The score for the category 'hate/threatening'.
          hate_threatening:,
          # The score for the category 'illicit'.
          illicit:,
          # The score for the category 'illicit/violent'.
          illicit_violent:,
          # The score for the category 'self-harm'.
          self_harm:,
          # The score for the category 'self-harm/instructions'.
          self_harm_instructions:,
          # The score for the category 'self-harm/intent'.
          self_harm_intent:,
          # The score for the category 'sexual'.
          sexual:,
          # The score for the category 'sexual/minors'.
          sexual_minors:,
          # The score for the category 'violence'.
          violence:,
          # The score for the category 'violence/graphic'.
          violence_graphic:
        )
        end

        sig do
          override.returns(
            {
              harassment: Float,
              harassment_threatening: Float,
              hate: Float,
              hate_threatening: Float,
              illicit: Float,
              illicit_violent: Float,
              self_harm: Float,
              self_harm_instructions: Float,
              self_harm_intent: Float,
              sexual: Float,
              sexual_minors: Float,
              violence: Float,
              violence_graphic: Float
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
