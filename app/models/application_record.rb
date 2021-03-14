# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: {
    writing: :primary,
    reading: :readonly
  }
  # Why? So we can keep upstream relationships without doing ID swaps. Keeps rails rails
  def self.attributes_protected_by_default
    # default is ["id", "type"]
    ['type']
  end
end
