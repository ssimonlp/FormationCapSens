# frozen_string_literal: true

class ProjectDecorator < SimpleDelegator
  def collect
    contributions.empty? ? "Nobody has contributed yet." : "#{collected[0]}$"
  end

  def progress
    contributions.empty? ? "Nobody has contributed yet." : "#{collected[1]}%"
  end

  def highest
    contributions.empty? ? "Nobody has contributed yet." : "#{rank[1]}$"
  end

  def lowest
    contributions. empty? ? "Nobody has contributed yet." : rank[0].to_s
  end
end
