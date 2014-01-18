sys = require('sys')
module.exports = (robot) ->
  robot.hear /(.*)/i, (msg) ->
    msg.send sys.inspect(eval("#{msg.match[0]}"))
