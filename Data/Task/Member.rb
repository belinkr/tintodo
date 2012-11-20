# encoding: utf-8
require 'forwardable'
require 'virtus'
require 'aequitas'
require 'Tinto/Member'

module Tintodo
  module Task
    class Member
      extend Forwardable
      include Virtus
      include Aequitas

      MODEL_NAME  = 'task'
      WHITELIST   = %w{ name }
      STATES      = %w{ completed pending }

      attribute :id,            String
      attribute :name,          String
      attribute :state,         String, default: 'pending'
      attribute :created_at,    Time
      attribute :updated_at,    Time
      attribute :deleted_at,    Time

      validates_presence_of     :id, :name, :state
      validates_length_of       :name, min: 1, max: 500
      validates_within          :state, set: STATES

      def_delegators :@member,  *Tinto::Member::INTERFACE

      def initialize(attributes={})
        self.attributes = attributes
        @member = Tinto::Member.new self
      end #initialize

      def storage_key
        "tasks:#{id}"
      end #storage_key

      def completed?
        self.state == 'completed'
      end #completed?

      def pending?
        !completed?
      end #pending?

      def complete
        self.state = 'completed'
      end #complete

      def uncomplete
        self.state = 'pending'
      end #uncomplete
    end # Member
  end # Task
end # Tintodo
  
