# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # Always prefix method names of validations with "validate"
      #
      # @example
      #   # bad
      #   validate :product_number_uniqueness
      #
      #   # good
      #   validate :validate_product_number_uniqueness
      class ValidationNaming < ::RuboCop::Cop::Base

        MSG = 'Always prefix method names of validations with "validate"'.freeze

        def on_send(node)
          if node.method_name.to_s == 'validate'
            #receiver_node, method_name, *arg_nodes = *node
            receiver_node = node.children.first
            
            if node.first_argument && receiver_node.nil?
              #key = node.first_argument.key
              value = node.first_argument.value

              if !value.to_s.start_with?("validate")
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
