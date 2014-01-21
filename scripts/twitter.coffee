# Description:
#   gets tweet from user
#
# Dependencies:
#   "twit": "1.1.6"
#   "underscore": "1.4.4"
#
# Configuration:
#   HUBOT_TWITTER_CONSUMER_KEY
#   HUBOT_TWITTER_CONSUMER_SECRET
#   HUBOT_TWITTER_ACCESS_TOKEN
#   HUBOT_TWITTER_ACCESS_TOKEN_SECRET
#
# Commands:
#   hubot twitter <twitter username> - Show last tweet from <twitter username>
#   hubot twitter <twitter username> <n> - Cycle through tweet with <n> starting w/ latest
#
# Author:
#   KevinTraver / Akash Devaraju
#

_ = require "underscore"
Twit = require "twit"
config =
  consumer_key: "9D11nTA1RRsfyjSwcTRyg"
  consumer_secret: "LS9y9ecvzKC2chQETQ6Ddf3m7cRUtiZHK0iZF6fN6M"
  access_token: "49951343-jtYerd2JL9LEfFv8gXQJDeDImcfAOJ8RZmvQhKSEg"
  access_token_secret: "dyH9lNeaOxKRsYXLjdC6r3v3tnBc6GfLW80ZZNdvWitwa"

module.exports = (robot) ->
  twit = undefined

  robot.respond /(twitter|lasttweet)\s+(\S+)\s?(\d?)/i, (msg) ->
    unless config.consumer_key
      msg.send "Please set the HUBOT_TWITTER_CONSUMER_KEY environment variable."
      return
    unless config.consumer_secret
      msg.send "Please set the HUBOT_TWITTER_CONSUMER_SECRET environment variable."
      return
    unless config.access_token
      msg.send "Please set the HUBOT_TWITTER_ACCESS_TOKEN environment variable."
      return
    unless config.access_token_secret
      msg.send "Please set the HUBOT_TWITTER_ACCESS_TOKEN_SECRET environment variable."
      return

    twit = new Twit config unless twit


    username = msg.match[2]
    if msg.match[3] then count = msg.match[3] else count = 1

    twit.get "statuses/user_timeline",
      screen_name: escape(username)
      count: count
      include_rts: false
      exclude_replies: true
    , (err, reply) ->
      return msg.send "Error" if err
      return msg.send _.unescape(_.last(reply)['text']) if reply[0]['text']
