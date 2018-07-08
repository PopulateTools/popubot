require "http"

module Lita
  module Handlers
    class Deploy < Handler
      config :host
      config :token

      route(/\Adeploy\s+(\w+)\s+(\w+)/, :deploy, help: { "deploy <application> <environment>" => "Deploy application into environment" })

      def deploy(response)
        application_name = response.matches[0][0]
        environment = response.matches[0][1]

        HTTP
          .headers({"Authorization" => "Token token=#{config.token}"})
          .post("#{config.host}/api/deploys/#{application_name}/#{environment}")

        response.reply("Deploying #{application_name} in #{environment}")
      end
    end

    Lita.register_handler(Deploy)
  end
end
