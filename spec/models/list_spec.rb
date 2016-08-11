require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Walk the dog")
      Task.create(complete: false, list_id: list.id, name: "Take out the trash")
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
    it 'should not change value of task which is already complete' do
      list = List.create(name: "play")
      Task.create(complete: true,list_id: list.id, name: "go out and play")
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do 
    it 'should mark deadline of all tasks from the list as 1 hour from now' do 
      list = List.create(name: "Chores")
      deadline = DateTime.new(2016, 10, 31)
      Task.create(deadline: deadline, list_id: list.id, name: "Walk the dog")
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(deadline + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'should add the duration of each task' do
      list = List.create(name: "Chores")
      Task.create(duration: 1, list_id: list.id, name: "Walk the dog")
      Task.create(duration: 3, list_id: list.id, name: "Walk the dog")
      total = list.total_duration
      expect(total). to eq(4)
    end
  end

  describe '#incomplete_tasks!' do 
    incomplete_tasks = []
    it 'should return all incomplete tasks' do 
      list = List.create(name: "Chores")
      deadline = 1.day.from_now
      Task.create(complete: false, list_id: list.id, name: "Walk the dog")
      Task.create(complete: true, list_id: list.id, name: "Throw trash")
      incomplete_tasks = list.incomplete_tasks
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
      expect(incomplete_tasks.count). to eq(1)
    end
  end

describe '#favorite_tasks' do 
    favorite_tasks = []
    it 'should return all favourite tasks' do 
      list = List.create(name: "Chores")
      Task.create(favorite: true, list_id: list.id, name: "Walk the dog")
      Task.create(favorite: true, list_id: list.id, name: "Throw trash")
      favorite_tasks = list.favorite_tasks
      favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
      expect(favorite_tasks.count). to eq(2)
    end
  end

end
