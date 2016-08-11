class List < ApplicationRecord
  has_many :tasks

  def complete_all_tasks!
    # tasks.each do |task|
    #   task.update(complete: true)
    # end
    tasks.update_all(complete:true)
  end

  def snooze_all_tasks!
    # tasks.each do |task|
    #   task.snooze_hour!
    # end
    tasks.each{|task| task.snooze_hour!}
  end

  def total_duration
  #   total = 0
  #   tasks.each do |task|
  #     total += task.duration
  #   end
  #   return total
  tasks.inject(0) { |sum,task| sum + task.duration }
  end

  def incomplete_tasks
    tasks.reject {|task| task.complete}
  end

  def favorite_tasks
    tasks.select {|task| task.favorite}
  end
end
