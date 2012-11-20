# encoding: utf-8
require 'minitest/autorun'
require 'ostruct'
require_relative '../../../Cases/CreateTask/Context'
require_relative '../../Doubles/Collection/Double'

include Tintodo

describe CreateTask::Context do
  it 'adds the task to the collection with all tasks' do
    task          = OpenStruct.new
    tasks         = Minitest::Mock.new
    pending_tasks = Collection::Double.new
    context       = CreateTask::Context.new(
      task:           task,
      tasks:          tasks,
      pending_tasks:  pending_tasks
    )

    tasks.expect :add, nil, [task]
    context.call
    tasks.verify
  end

  it 'adds the task to the pending tasks collection' do
    task          = OpenStruct.new
    tasks         = Collection::Double.new
    pending_tasks = Minitest::Mock.new
    context       = CreateTask::Context.new(
      task:           task,
      tasks:          tasks,
      pending_tasks:  pending_tasks
    )

    pending_tasks.expect :add, nil, [task]
    context.call
    pending_tasks.verify
  end
end # CreateTask::Context

