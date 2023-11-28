require "openai"
require "json"

class OpenaiRequestJob < ApplicationJob
  queue_as :default

  def perform(bookmark_id, html_content)
    ActiveRecord::Base.transaction do
      bookmark = Bookmark.find(bookmark_id)
      client = OpenAI::Client.new

      # add to the summary the bookmark html_content + a custom prompt
      prompt = "Desde este contenido HTML hazme un resumen:\n\n"
      +"Este es el contenido:\n\n"

      end_user = prompt + "' #{html_content} '"

      response = client.chat(
        parameters: {
          #model: "gpt-3.5-turbo", # Required.
          model: "gpt-4", # Required.
          messages: [
            { role: "user", content: end_user },
          ], # Required.
          temperature: 0.7,
        },
      )

      answer = response.dig("choices", 0, "message", "content")

      prompt_2 = "Ahora de este contenido dime si es true o false undercase para que ruby lo pueda leer, solo retorname el valor booleano, nada mas, no quiero notas, no quiero explicaciones, solo el valor booleano:\n\n"

      end_user_2 = prompt_2 + "' #{answer} '"

      response = client.chat(
        parameters: {
          #model: "gpt-3.5-turbo", # Required.
          model: "gpt-4", # Required.
          messages: [
            { role: "user", content: end_user_2 },
          ], # Required.
          temperature: 0.7,
        },
      )

      answer_2 = response.dig("choices", 0, "message", "content")

      puts "ANSWERRRRRR RESUMEEN:"
      puts answer

      puts "ANSWERRRRRR IS TRUE:"
      puts answer_2

      # create the json
      answer_2_boolean = answer_2.downcase == "true" ? true : false
      json = { "summarize": answer, "isTrue": answer_2_boolean }.to_json

      begin
        summary = JSON.parse(json)["summarize"]
        is_true = JSON.parse(json)["isTrue"]

        # Update the bookmark with the summary and isTrue
        bookmark.update(summary: summary, is_true: is_true)

        puts "Summary: #{summary}"
        puts "Is True: #{is_true}"
      rescue JSON::ParserError => e
        puts "Error reading the JSON: #{e.message}"
      end
    end
  end
end
