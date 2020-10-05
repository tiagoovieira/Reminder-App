# frozen_string_literal: true

require 'rails_helper'

describe Reminder do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :remind_at }
end
