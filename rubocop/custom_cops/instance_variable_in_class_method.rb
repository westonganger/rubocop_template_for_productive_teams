# frozen_string_literal: true

### https://github.com/covermymeds/rubocop-thread_safety/blob/master/lib/rubocop/cop/thread_safety/instance_variable_in_class_method.rb

module RuboCop
  module Cop
    module Custom
      # Avoid instance variables in class methods for thread safety.
      #
      # @example
      #   # bad
      #   class User
      #     def self.notify(info)
      #       @info = validate(info)
      #       Notifier.new(@info).deliver
      #     end
      #   end
      #
      #   class Model
      #     class << self
      #       def table_name(name)
      #         @table_name = name
      #       end
      #     end
      #   end
      #
      #   class Host
      #     %i[uri port].each do |key|
      #       define_singleton_method("#{key}=") do |value|
      #         instance_variable_set("@#{key}", value)
      #       end
      #     end
      #   end
      #
      #   module Example
      #     module ClassMethods
      #       def test(params)
      #         @params = params
      #       end
      #     end
      #   end
      class InstanceVariableInClassMethod < ::RuboCop::Cop::Base
        MSG = 'Avoid instance variables in class methods for thread safety.'

        def_node_matcher :instance_variable_set_call?, <<~MATCHER
          (send nil? :instance_variable_set (...) (...))
        MATCHER

        def_node_matcher :instance_variable_get_call?, <<~MATCHER
          (send nil? :instance_variable_get (...))
        MATCHER

        def on_ivar(node)
          return unless class_method_definition?(node)
          return if synchronized?(node)

          add_offense(node, location: :name, message: MSG)
        end
        alias on_ivasgn on_ivar

        def on_send(node)
          return unless instance_variable_call?(node)
          return unless class_method_definition?(node)
          return if synchronized?(node)

          add_offense(node, message: MSG)
        end

        private

        def class_method_definition?(node)
          in_defs?(node) ||
            in_def_sclass?(node) ||
            in_def_class_methods?(node) ||
            singleton_method_definition?(node)
        end

        def in_defs?(node)
          node.ancestors.any? do |ancestor|
            ancestor.type == :defs
          end
        end

        def in_def_sclass?(node)
          defn = node.ancestors.find do |ancestor|
            ancestor.type == :def
          end

          defn&.ancestors&.any? do |ancestor|
            ancestor.type == :sclass
          end
        end

        def in_def_class_methods?(node)
          defn = node.ancestors.find(&:def_type?)
          return unless defn

          types = %i[class module]

          mod = defn.ancestors.find do |ancestor|
            types.include?(ancestor.type)
          end
          return unless mod

          class_methods_module?(mod)
        end

        def singleton_method_definition?(node)
          node.ancestors.any? do |ancestor|
            next unless ancestor.children.first.is_a? AST::SendNode

            ancestor.children.first.command? :define_singleton_method
          end
        end

        def synchronized?(node)
          node.ancestors.find do |ancestor|
            next unless ancestor.block_type?

            s = ancestor.children.first
            s.send_type? && s.children.last == :synchronize
          end
        end

        def instance_variable_call?(node)
          instance_variable_set_call?(node) || instance_variable_get_call?(node)
        end

        def_node_matcher :class_methods_module?, <<~PATTERN
          (module (const _ :ClassMethods) ...)
        PATTERN
      end
    end
  end
end
