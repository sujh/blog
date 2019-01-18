class SearchController < ApplicationController

  def index
    @query = params[:q].to_s
    search_params = {
      query: {
        simple_query_string:{
          fields: %w(title content),
          query: @query
        }
      },
      highlight: {
        fields: {
          content: {
            number_of_fragments: 1,
            fragment_size: 200
          },
          title: {}
        }
      }
    }
    @hits = Elasticsearch::Model.search(search_params, Post).page(params[:page]).records
  end

end