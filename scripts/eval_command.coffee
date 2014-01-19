sys = require('sys')
module.exports = (robot) ->
  robot.hear /eval (.*)/i, (msg) ->
    msg.send sys.inspect(eval("#{msg.match[1]}"))
