# encoding: utf-8
require 'minitest/autorun'
require_relative '../../../Data/Task/Member'
require_relative '../../../Locales/Loader'

include Tintodo

describe Task::Member do
  describe 'validations' do
    describe '#id' do
      it 'must be present' do
        task    = Task::Member.new
        task.id = nil
        task.valid?.must_equal false
        task.errors.fetch(:id).must_include 'id must not be blank'
      end
    end #id

    describe '#name' do
      it 'must be present' do
        task = Task::Member.new
        task.valid?.must_equal false
        task.errors.fetch(:name).must_include 'name must not be blank'
      end

      it 'must have a minimum length of 1 character' do
        task = Task::Member.new(name: '')
        task.valid?.must_equal false
        task.errors.fetch(:name)
          .must_include 'name must be between 1 and 500 characters long'
      end

      it 'must have a maximum length of 500 characters' do
        task = Task::Member.new(name: 'a' * 501)
        task.valid?.must_equal false
        task.errors.fetch(:name)
          .must_include 'name must be between 1 and 500 characters long'
      end
    end #name

    describe '#state' do
      it 'must be present' do
        task    = Task::Member.new
        task.state = nil
        task.valid?.must_equal false
        task.errors.fetch(:state).must_include 'state must not be blank'
      end
    end #state
  end # validations

  describe 'member API' do
    it 'implements the Tinto::Member API' do
      tasks = Task::Member.new
      Tinto::Member::INTERFACE.each do |method|
        tasks.respond_to?(method).must_equal true
      end
    end
  end # set API

  describe '#complete' do
    it 'marks the task as completed' do
      task = Task::Member.new
      task.completed?.must_equal false
      task.complete
      task.completed?.must_equal true
    end
  end #complete

  describe '#uncomplete' do
    it 'marks the task as pending' do
      task = Task::Member.new
      task.completed?.must_equal false
      task.complete
      task.completed?.must_equal true
      task.uncomplete
      task.pending?.must_equal true
    end
  end #uncomplete

  describe '#completed?' do
    it 'returns true if the task is completed' do
      task = Task::Member.new
      task.completed?.must_equal false

      task = Task::Member.new(state: 'pending')
      task.completed?.must_equal false
    end
  end #completed?

  describe '#pending?' do
    it 'returns true if the task is uncompleted' do
      task = Task::Member.new(state: 'pending')
      task.pending?.must_equal true
    end
  end #uncompleted?
end # Task::Member

