# encoding: utf-8
require 'json'
require 'Tinto/Presenter'

module Tintodo
  module Task
    class Presenter
      def initialize(member, actor=nil)
        @member = member
      end #initialize

      def as_json
        as_poro.to_json
      end #as_json

      def as_poro
        {
          id:     member.id,
          name:   member.name,
          state:  member.state
        }.merge! Tinto::Presenter.timestamps_for(member)
         .merge! Tinto::Presenter.errors_for(member)
         .merge! links
      end #as_poro

      private

      def links
        { 
          links: { 
            self:       "/tasks/#{member.id}",
            complete:   "/tasks/completed/#{member.id}",
            uncomplete: "/tasks/pending/#{member.id}"
          } 
        }
      end #links

      attr_reader :member
    end # Presenter
  end # Task
end # Tintodo

