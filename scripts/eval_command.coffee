# Description:
#   In Room Debugging tool
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   eval <code>
#
# Notes:
#   None
#
# Author:
#   VinayNadig

sys = require('sys')
module.exports = (robot) ->
  robot.hear /eval (.*)/i, (msg) ->
    msg.send sys.inspect(eval("#{msg.match[1]}"))
