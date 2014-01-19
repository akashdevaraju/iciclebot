sys = require('sys')

create_new_user_object = (args) ->
  user_object = { user_id: args[2], details: { user_name: args[3], last_msg_room_id: args[4], last_updated_time: new Date , messages : [], has_training: args[6], do_not_bug: args[7], dob: args[8], email: args[9], trainings: [] } }
  user_object.details.messages.push args[5]
  args[1].brain["user_data"].push user_object

module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.hear /(.*)/i, (msg) ->
      user_id = msg.message.user.id.toString()
      user_name = msg.message.user.name
      room_id = msg.message.user.room_id
      message = msg.message.text
      has_training = true
      do_not_bug = false
      dob = null
      email = null
      args = [msg, robot, user_id, user_name, room_id, message, has_training, do_not_bug, dob, email]

      if robot.brain["user_data"]
        user_object = user for user in robot.brain["user_data"] when user.user_id == user_id
        if user_object
          user_object.details.messages.push message
          user_object.details.last_updated_time = new Date
          user_object.details.role = ''
          user_object.details.has_training = true
          user_object.details.do_not_bug = do_not_bug
          user_object.details.dob = dob
          user_object.details.email = email
          user_object.details.trainings = []
        else
          create_new_user_object(args)
      else
        robot.brain["user_data"] = []
        create_new_user_object(args)
    robot.brain.emit 'save'
