# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      include Paginable

      def index
        paginated = paginate(Article.recent)
        render_collection(paginated)
      end

      def show
        article = Article.find(params[:id])
        render json: serializer.new(article)
      end

      def serializer
        ArticleSerializer
      end
    end
  end
end
