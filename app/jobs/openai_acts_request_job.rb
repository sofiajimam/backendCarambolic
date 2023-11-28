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

      prompt = "Desde este contenido, hazme una historia de 3 actos:\n\n"
      +" para crear imagenes con esas actos, cada acto va tener no mas de 2 lineas de contenido, su titulo y el prompt para la imagen, "
      +" con la siguiente estructura: ''titulo': contenido. 'prompt': prompt para la imagen. \n\n' 'titulo': contenido. 'prompt': prompt para la imagen. \n\n' 'titulo': contenido. 'prompt': prompt para la imagen. \n\n"
      +"No regreses nada mas que los 3 actos, no quiero notas, no quiero explicaciones, solo los 3 actos:\n\n"
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

      #puts "ANSWERRRRRR ACTS:"
      #puts answer

      # create the json
      # following structure: [{title: "title", body: "body", prompt: "prompt"}, {title: "title", body: "body", prompt: "prompt"}, {title: "title", body: "body", prompt: "prompt"}]
      # and the text has the following structure:
      # Act I: title
      #\n
      # body
      #\n
      # prompt = first sentence until "."

      acts = answer.split("\n\n")

      # make 0 and 1 first act, 2 and 3 second act, 4 and 5 third act
      act1 = "#{acts[0]}\n\n#{acts[1]}" if acts[0] && acts[1]
      act2 = "#{acts[2]}\n\n#{acts[3]}" if acts[2] && acts[3]
      act3 = "#{acts[4]}\n\n#{acts[5]}" if acts[4] && acts[5]

      # get all acts together
      acts_together = [act1, act2, act3]

      json_array = []

      acts_together.each_with_index do |act, index|
        act_array = act.split("\n\n")
        act_title = act_array[0]
        act_body = act_array[1]
        act_prompt = act_body.split(".")[1]

        json_array.push({ "title": act_title, "body": act_body, "prompt": act_prompt })
      end

      puts "JSON ARRAY:"
      puts json_array

      begin
        # call for each act the job "dalle"
        DalleRequestJob.perform_later(story_id, json_array[0].to_json, 1)
        DalleRequestJob.perform_later(story_id, json_array[1].to_json, 2)
        DalleRequestJob.perform_later(story_id, json_array[2].to_json, 3)
      rescue => e
        puts "Error: #{e}"
      end
    end
  end
end
