# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ArticlesController do
  describe '#index' do
    let(:url) { '/api/v1/articles' }
    it 'returns a success response' do
      get url
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      article = create :article
      get url
      expect(json_data.length).to eq(1)
      expected = json_data.first
      aggregate_failures do
        expect(expected[:id]).to eq(article.id.to_s)
        expect(expected[:type]).to eq('article')
        expect(expected[:attributes]).to eq(
          title: article.title,
          content: article.content,
          slug: article.slug
        )
      end
    end

    it 'returns articles in the proper order' do
      older_article =
        create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)
      get url
      ids = json_data.map { |item| item[:id].to_i }
      expect(ids).to(
        eq([recent_article.id, older_article.id])
      )
    end

    it 'paginates results' do
      article1, article2, article3 = create_list(:article, 3)
      get url, params: { page: { number: 2, size: 1 } }
      expect(json_data.length).to eq(1)
      expect(json_data.first[:id]).to eq(article2.id.to_s)
    end

    it 'contains pagination links in the response' do
      article1, article2, article3 = create_list(:article, 3)
      get url, params: { page: { number: 2, size: 1 } }
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(
        :first, :prev, :next, :last, :self
      )
    end
  end

  describe '#show' do
    let(:article) { create :article }

    subject { get "/api/v1/articles/#{article.id}" }

    before { subject }

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON' do
      aggregate_failures do
        expect(json_data[:id]).to eq(article.id.to_s)
        expect(json_data[:type]).to eq('article')
        expect(json_data[:attributes]).to eq(
          title: article.title,
          content: article.content,
          slug: article.slug
        )
      end
    end
  end
end
