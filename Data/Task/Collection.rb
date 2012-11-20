# encoding: utf-8
require 'forwardable'
require 'virtus'
require 'aequitas'
require 'Tinto/Set'
require_relative './Member'

module Tintodo
  module Task
    class Collection
      extend Forwardable
      include Virtus
      include Aequitas
      include Enumerable

      KINDS       = %w{ all pending completed }
      MODEL_NAME  = 'task'

      attribute :kind,      String
      validates_presence_of :kind
      validates_within      :kind, set: KINDS

      def_delegators :@set, *Tinto::Set::INTERFACE

      def initialize(attributes={})
        @set = Tinto::Set.new self
        self.attributes = attributes
      end #initialize
 
      def storage_key
        'tasks'
      end #storage_key

      def instantiate_member(attributes={})
        Member.new(attributes)
      end #instantiate_member
    end # Collection
  end # Task
end # Tintodo

