# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#validations' do
    let(:article) { build(:article) }

    it 'test article object' do
      expect(article.title).to eq('Sample article')
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
end
