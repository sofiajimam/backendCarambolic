require "openai"
require "json"

class DalleRequestJob < ApplicationJob
  queue_as :default

  def perform(act_id, summarize)
    # Do something later
  end
end
