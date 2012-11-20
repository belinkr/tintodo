# encoding: utf-8
require 'minitest/autorun'
require 'ostruct'
require_relative '../../../Cases/UncompleteTask/Context'
require_relative '../../Doubles/Collection/Double'

include Tintodo

describe UncompleteTask::Context do
  before do
    @task            = OpenStruct.new
    @pending_tasks   = Collection::Double.new
    @completed_tasks = Collection::Double.new
  end

  it 'marks the task as pending' do
    task    = Minitest::Mock.new
    context = UncompleteTask::Context.new(
      task:             task,
      completed_tasks:  @completed_tasks,
      pending_tasks:    @pending_tasks
    )

    task.expect :uncomplete, nil
    context.call
    task.verify
  end

  it 'deletes the task from the completed tasks collection' do
    completed_tasks = Minitest::Mock.new
    context         = UncompleteTask::Context.new(
      task:             @task,
      completed_tasks:  completed_tasks,
      pending_tasks:    @pending_tasks
    )

    completed_tasks.expect :delete, nil, [@task]
    context.call
    completed_tasks.verify
  end

  it 'add the task to the pending tasks collection' do
    pending_tasks     = Minitest::Mock.new
    context           = UncompleteTask::Context.new(
      task:             @task,
      completed_tasks:  @completed_tasks,
      pending_tasks:    pending_tasks
    )

    pending_tasks.expect :add, nil, [@task]
    context.call
    pending_tasks.verify
  end
end # UncompleteTask::Context

