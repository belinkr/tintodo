# encoding: utf-8
require 'minitest/autorun'
require_relative '../../../Locales/Loader'
require_relative '../../../Data/Task/Collection'

include Tintodo

describe Task::Collection do
  describe 'validations' do
    describe '#kind' do
      it 'must be present' do
        tasks = Task::Collection.new
        tasks.valid?.must_equal false
        tasks.errors.fetch(:kind).must_include 'kind must not be blank'
      end

      it 'must be one of the expected kinds' do
        kinds = Task::Collection::KINDS.join(', ')
        tasks = Task::Collection.new(kind: 'wrong')
        tasks.valid?.must_equal false
        tasks.errors.fetch(:kind).must_include "kind must be one of #{kinds}"
      end
    end #kind
  end # validations

  describe 'set API' do
    it 'implements the Tinto::Set API' do
      tasks = Task::Collection.new
      Tinto::Set::INTERFACE.each do |method|
        tasks.respond_to?(method).must_equal true
      end
    end
  end # set API
end # Task::Collection

