module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.hear /(.*)going through(.*)((http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?)/i, (msg) ->
      user_id = msg.message.user.id.toString()
      user_object = user for user in robot.brain["user_data"] when user.user_id == user_id
      training_link = msg.match[3]
      training_time = new Date
      obj = ({ training_time: training_time, training_link: training_link })
      user_object.details.trainings.push obj
      robot.brain.emit 'save'

