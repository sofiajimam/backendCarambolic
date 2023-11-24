require "openai"
require "json"

class DalleRequestJob < ApplicationJob
  queue_as :default

  def perform(story_id, act, act_number)
    story = Story.find(story_id)
    client = OpenAI::Client.new

    prompt = act["prompt"]
    response = client.images.generate(parameters: { prompt: prompt, size: "1024x1024" })

    answer = response.dig("data", 0, "url")

    puts "answer: #{answer}"

    # create the act
    act = ::Act.new(
      title: act["title"],
      body: act["body"] + " --#{act_number}",
      image: answer,
      story_id: story_id,
    )

    act.save!
  end
end
