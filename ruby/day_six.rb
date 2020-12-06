class QuizCounter
  attr_reader :groups

  def initialize(input)
    @groups = input.split("\n\n").map do |group|
      GroupCounter.new(group)
    end
  end

  def sum_uniq_answers
    @groups.sum(&:uniq_answers)
  end

  def sum_everyone_answers
    @groups.sum(&:everyone_answers)
  end
end

class GroupCounter
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def member_count
    @member_count ||= str.split("\n").count
  end

  def all_answers
    @all_answers ||= str.split('').reject { |c| !c.match(/[a-z]/) }
  end

  def uniq_answers
    all_answers.uniq.count
  end

  def everyone_answers
    all_answers.tally.select { |_answer, count| count == member_count }.count
  end
end
