# encoding: utf-8
require 'minitest/autorun'
require 'ostruct'
require_relative '../../../Cases/CompleteTask/Context'
require_relative '../../Doubles/Collection/Double'

include Tintodo

describe CompleteTask::Context do
  before do
    @task            = OpenStruct.new
    @pending_tasks   = Collection::Double.new
    @completed_tasks = Collection::Double.new
  end

  it 'marks the task as completed' do
    task    = Minitest::Mock.new
    context = CompleteTask::Context.new(
      task:             task,
      completed_tasks:  @completed_tasks,
      pending_tasks:    @pending_tasks
    )

    task.expect :complete, nil
    context.call
    task.verify
  end

  it 'adds the task to the completed tasks collection' do
    completed_tasks = Minitest::Mock.new
    context         = CompleteTask::Context.new(
      task:             @task,
      completed_tasks:  completed_tasks,
      pending_tasks:    @pending_tasks
    )

    completed_tasks.expect :add, nil, [@task]
    context.call
    completed_tasks.verify
  end

  it 'deletes the task from the pending tasks collection' do
    pending_tasks     = Minitest::Mock.new
    context           = CompleteTask::Context.new(
      task:             @task,
      completed_tasks:  @completed_tasks,
      pending_tasks:    pending_tasks
    )

    pending_tasks.expect :delete, nil, [@task]
    context.call
    pending_tasks.verify
  end
end # CompleteTask::Context

