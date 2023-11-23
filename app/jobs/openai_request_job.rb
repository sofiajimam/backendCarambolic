require "openai"
require "json"

class OpenaiRequestJob < ApplicationJob
  queue_as :default

  def perform(bookmark_id, html_content)
    bookmark = Bookmark.find(bookmark_id)
    client = OpenAI::Client.new

    # add to the summary the bookmark html_content + a custom prompt
    prompt = "Desde este contenido HTML, devolverás un JSON de la siguiente manera: {'summarize': " ", 'isTrue': true || false}. "
    +"'Summarize' es el resumen del contenido HTML, y 'isTrue' solo devolverá 'true' o 'false', ya que evaluarás el contenido y  "
    +"determinarás si lo que se dice es verdadero o falso. No regreses nada mas, solo el JSON. Las comillas dobles agregale las barras invertidas y/o escapalas. "
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

    # from the json parse the summary and isTrue
    json_string = answer.gsub("'", '"')

    json_data = JSON.parse(json_string)

    summary = json_data["summarize"]
    is_true = json_data["isTrue"]

    puts "summary: #{summary}"
    puts "is_true: #{is_true}"

    bookmark.update(summary: summary, is_true: is_true)
  end
end
