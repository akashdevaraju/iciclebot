# Description:
#   updates robot.brain.user_data with the most recent training update
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot > - <what the respond trigger does>
#   self training <link_name> - saves training link and time
#   going through <link_name> - saves training link and time
#   went through <link_name> - saves training link and time
#
# Notes:
#   None
#
# Author:
#   VinayNadig

update_training = (msg, robot) ->
  user_id = msg.message.user.id.toString()
  user_object = user for user in robot.brain["user_data"] when user.user_id == user_id
  training_link = msg.match[3]
  training_time = new Date
  obj = ({ training_time: training_time, training_link: training_link })
  user_object.details.trainings.push obj
  robot.brain.emit 'save'

module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.hear /(.*)going through(.*)((http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/i, (msg) ->
      update_training(msg, robot)

    robot.hear /(.*)went through(.*)((http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/i, (msg) ->
      update_training(msg, robot)

    robot.hear /(.*)self training(.*)((http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/i, (msg) ->
      update_training(msg, robot)
