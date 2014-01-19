sys = require('sys')
module.exports = (robot) ->
  robot.hear /(.*)/i, (msg) ->
    robot.brain.user_data = {} unless robot.brain.user_data

