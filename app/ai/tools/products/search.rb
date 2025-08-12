class Tools::Products::Search < RubyLLM::Tool
  description "search for a product - if user is asking for a spcific product or a category of products"

  param :query,
    desc: "The search query", required: true

  def execute(query:)
    uri = URI('https://dummyjson.com/products/search?limit=5&q=' + query)
    response = Net::HTTP.get_response(uri)

    if response.code == '200'
     response.body
    else
      "something went wrong with the search please, try again"
    end
  end
end
