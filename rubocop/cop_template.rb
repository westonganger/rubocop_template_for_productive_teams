# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      # Avoid example
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
      class Example < ::RuboCop::Cop::Base
        # extend AutoCorrector

        ### For send nodes
        ### receiver_node, method_name, *arg_nodes = *send_node
        ### receiver_node, method_name, arg_nodes = [block_node.children.first, send_node.method_name, block_node.arguments]
        
        ### For block nodes
        ### receiver_node, *arg_nodes = *block_node
        ### receiver_node, arg_nodes = [block_node.children.first, block_node.arguments]
        
        ### For arg nodes
        ### key, value = *arg_node
        ### key, value = [arg_node.key, arg_node.value]

        MSG = 'Avoid example.'.freeze

        # def on_send(node)
        #   if node.method_name.to_s == 'validate'
        #     if node.first_argument.nil? && node.block_node
        #       add_offense(node, message: MSG)
        #     end
        #   end
        # end
        
        # def on_block(node)
        #   receiver_node = node.children.first

        #   if receiver_node.method_name.to_s == 'validate' && receiver_node.first_argument.nil?
        #     add_offense(receiver_node, message: MSG)
        #   end
        # end

        private

        # def autocorrect(arg_pair)
        #   false 
        # end
      end
    end
  end
end
