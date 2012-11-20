# encoding: utf-8
require 'rubygems'
require 'minitest/autorun'
require 'minitest/mock'
require 'ostruct'
require_relative '../../../Cases/DeleteTask/Context'
require_relative '../../Doubles/Collection/Double'

include Tintodo

describe DeleteTask::Context do
  before do
    @task            = OpenStruct.new
    @tasks           = Collection::Double.new
    @pending_tasks   = Collection::Double.new
    @completed_tasks = Collection::Double.new
  end

  it 'deletes the task' do
    task    = MiniTest::Mock.new
    context = DeleteTask::Context.new(
      task:             task,
      tasks:            @tasks,
      pending_tasks:    @pending_tasks,
      completed_tasks:  @completed_tasks,
    )
    task.expect :delete, nil
    context.call
    task.verify
  end

  it 'deletes the task from the all tasks collection' do
    tasks   = MiniTest::Mock.new
    context = DeleteTask::Context.new(
      task:             @task,
      tasks:            tasks,
      pending_tasks:    @pending_tasks,
      completed_tasks:  @completed_tasks,
    )
    tasks.expect :delete, nil, [@task]
    context.call
    tasks.verify
  end

  it 'deletes the task from the pending tasks collection' do
    pending_tasks = MiniTest::Mock.new
    context       = DeleteTask::Context.new(
      task:             @task,
      tasks:            @tasks,
      pending_tasks:    pending_tasks,
      completed_tasks:  @completed_tasks,
    )
    pending_tasks.expect :delete, nil, [@task]
    context.call
    pending_tasks.verify
  end

  it 'deletes the task from the completed tasks collection' do
    completed_tasks = MiniTest::Mock.new
    context         = DeleteTask::Context.new(
      task:             @task,
      tasks:            @tasks,
      pending_tasks:    @pending_tasks,
      completed_tasks:  completed_tasks,
    )
    completed_tasks.expect :delete, nil, [@task]
    context.call
    completed_tasks.verify
  end
end # DeleteTask::Context

