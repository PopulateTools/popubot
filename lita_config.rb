require_relative "./lib/lita/handlers/deploy"

Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = "Popubot"

  # The locale code for the language to use.
  config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  config.robot.adapter = ENV["ENVIRONMENT"] == "development" ? :shell : :slack
  config.adapters.slack.token = ENV["SLACK_TOKEN"]

  config.adapters.slack.link_names = true
  config.adapters.slack.parse = "full"
  config.adapters.slack.unfurl_links = false
  config.adapters.slack.unfurl_media = false

  config.redis = { host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"] }

  config.http.port = "9999"

  # Deploy bot plugin
  config.handlers.deploy.host = ENV["DEPLOY_BOT_HOST"]
  config.handlers.deploy.token = ENV["DEPLOY_BOT_TOKEN"]

  # Sensu plugin
  config.handlers.sensu2.api_url = ENV["SENSU_API_URL"]
  config.handlers.sensu2.api_port = ENV["SENSU_API_PORT"].to_i
  config.handlers.sensu2.domain = ENV["SENSU_DOMAIN"]
end
