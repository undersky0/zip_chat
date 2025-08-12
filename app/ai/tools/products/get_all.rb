class Tools::Products::GetAll < RubyLLM::Tool
  description "get products - returns a list of products"

  def execute
    uri = URI('https://dummyjson.com/products')
    response = Net::HTTP.get_response(uri)

    if response.code == '200'
      JSON.parse(response.body)
    else
      response.message
    end
  end
end
