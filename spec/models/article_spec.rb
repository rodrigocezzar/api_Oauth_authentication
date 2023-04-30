# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validations' do
    let(:article) { build(:article) }

    it 'test article object' do
      expect(article.title).to eq('Sample article 1')
    end

    it 'test that factory is valid' do
      article = FactoryBot.create(:article)
      expect(article).to be_valid
    end

    it { should validate_presence_of(:title).with_message("can't be blank") }

    it { should validate_presence_of(:content).with_message("can't be blank") }

    it { should validate_presence_of(:slug).with_message("can't be blank") }

    it { should validate_uniqueness_of(:slug) }
  end

  describe '.recent' do
    it 'returns articles in the correct order' do
      older_article =
        create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      expect(described_class.recent).to eq(
        [recent_article, older_article]
      )

      recent_article.update_column(:created_at, 2.hours.ago)

      expect(described_class.recent).to eq(
        [older_article, recent_article]
      )
    end
  end
end
