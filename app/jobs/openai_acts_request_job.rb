require "openai"
require "json"

class OpenaiActsRequestJob < ApplicationJob
  queue_as :default

  def perform(bookmark_id, summarize, story_id)
    ActiveRecord::Base.transaction do
      bookmark = Bookmark.find(bookmark_id)

      #create story
      story = ::Story.new(
        is_public: false,
        bookmark_id: bookmark_id,
        title: bookmark.title,
        url: bookmark.url,
        thumbnail: bookmark.thumbnail,
      )

      story.save!

      client = OpenAI::Client.new

      prompt = "Desde este contenido, devolverás un JSON de la siguiente manera: {'act1': {'title': '', 'body': '', 'prompt': ''}, {'act2': {'title': '', 'body': '', 'prompt': ''},{'act3': {'title': '', 'body': '', 'prompt': ''}, }. "
      +"Vas a contar una historia vas a dividirlo en 3 actos para crear imagenes con esas frases, 'act1' es la primera, 'act2' es la segunda, 'act3' es la ultima. "
      +"'title' es el titulo del acto, 'body' es el contenido o descripcion del acto, y 'prompt'es para que regreses el prompt necesario para crear una imagen a partir del body y el title del acto."
      +"No regreses nada mas, solo el JSON. Las comillas dobles agregale las barras invertidas y/o escapalas. "
      +"Este es el contenido:\n\n"

      end_user = prompt + "' #{summarize} '"

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

      # from the json parse the 3 acts
      json_string = answer.gsub("'", '"')

      json_data = JSON.parse(json_string)

      act1 = json_data["act1"]
      act2 = json_data["act2"]
      act3 = json_data["act3"]

      puts "act1: #{act1}"
      puts "act2: #{act2}"
      puts "act3: #{act3}"

      # call for each act the job "dalle"
      DalleRequestJob.perform_later(story_id, act1, 1)
      DalleRequestJob.perform_later(story_id, act2, 2)
      DalleRequestJob.perform_later(story_id, act3, 3)
    end
  end
end
