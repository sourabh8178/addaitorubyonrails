class QuizController < ApplicationController
  def index
  end

  def generate
    debugger
    api_key = ENV['OPENAI_API_KEY']
    service = OpenAiService.new(api_key)
    topic = params[:topic]
    question = service.generate_question(topic)
    
    render json: { question: question }
  end
end
