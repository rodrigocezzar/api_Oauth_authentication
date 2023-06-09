# frozen_string_literal: true

# This is the class for articles in the application.
class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
end
