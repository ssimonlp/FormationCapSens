# frozen_string_literal: true

if Rails.env.development?
  module BetterErrorsHugeInspectWarning
    def inspect_value(obj)
      inspected = obj.inspect
      if inspected.size > 100_000
        inspected = "Object was too large to inspect (#{inspected.size} bytes). " \
          "Implement #{obj.class}#inspect if you need the details."
      end
      CGI.escapeHTML(inspected)
    rescue NoMethodError
      "<span class='unsupported'>(object doesn't support inspect)</span>"
    rescue Exception
      "<span class='unsupported'>(exception was raised in inspect)</span>"
    end
  end

  BetterErrors::ErrorPage.prepend(BetterErrorsHugeInspectWarning)
end
