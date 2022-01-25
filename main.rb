require 'dotenv'
require 'discordrb'
require 'slack-notifier'

Dotenv.load

slack = Slack::Notifier.new(ENV['SLACK_CHANNEL_URI'], username: 'discord通知Bot', icon_emoji: ':video_game:')

bot = Discordrb::Commands::CommandBot.new(
  token: ENV['DISCORD_BOT_TOKEN'],
  client_id: ENV['DISCORD_CLIENT_ID'],
  prefix: '/',
)

bot.voice_state_update do |event|
    user = event.user.name

    puts user

    if event.channel == nil then
        channel_name = event.old_channel.name

        slack.ping("#{user} が #{channel_name}を退出")
    else
        channel_name = event.channel.name

        slack.ping("#{user} が #{channel_name}に入りました")
    end
end


bot.run
