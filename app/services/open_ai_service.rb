class OpenAiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize(api_key)
    @headers = {
      "Authorization" => "Bearer #{api_key}",
      "Content-Type" => "application/json"
    }
  end

  def generate_question(topic)
    prompt = "Generate a quiz question on the topic: #{topic}"
    body = {
      model: "gpt-3.5-turbo",  # Use a valid model name
      messages: [{role: "system", content: "You are a quiz question generator."}, {role: "user", content: prompt}],
      max_tokens: 100
    }.to_json

    response = self.class.post("/chat/completions", headers: @headers, body: body)
    parsed_response = response.parsed_response
    if response.success? && parsed_response["choices"]
      parsed_response["choices"][0]["message"]["content"]
    else
      "Error generating question: #{parsed_response["error"]["message"]}"
    end
  rescue => e
    "Error: #{e.message}"
  end
end
