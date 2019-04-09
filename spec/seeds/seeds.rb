# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "db:seed" do
  it "works" do
    expect { Rails.application.load_seed }.to_not raise_error
  end
  it "creates + 15 users" do
    expect { Rails.application.load_seed }.to change(Foo, :count).by(+15)
  end
end
