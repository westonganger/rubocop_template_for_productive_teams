# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # Avoid unamed validations
      #
      # @example
      #   # bad
      #   validate { }
      #
      #   validate do
      #     
      #   end
      #
      #
      #   # good
      #   validate :validate_product_number_uniqueness
      #   validate :validate_product_code
      #
      #   private
      #
      #   def validate_product_number_uniqueness
      #   end
      #
      #   def validate_product_code
      #   end
      class NamedValidations < ::RuboCop::Cop::Base

        MSG = 'Avoid unamed validations.'.freeze

        def on_send(node)
          if node.method_name.to_s == 'validate'
            receiver_node = node.children.first

            if !receiver_node
              if node.first_argument.nil? && node.block_node
                add_offense(node, message: MSG)
              end
            end
          end
        end

        private

      end
    end
  end
end
