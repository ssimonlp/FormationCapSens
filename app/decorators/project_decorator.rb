# frozen_string_literal: true

class ProjectDecorator < Draper::Decorator
  delegate_all

  def no_contribution
    "Nobody has contributed yet."
  end

  def collected
    contributions.empty? ?  no_contribution : "#{collect[0]}$"
  end

  def progress
    contributions.empty? ? no_contribution : "#{collect[1]}%"
  end

  def highest
    contributions.empty? ? no_contribution : "#{rank[1]}$"
  end

  def lowest
    contributions. empty? ? no_contribution : rank[0].to_s
  end
end
