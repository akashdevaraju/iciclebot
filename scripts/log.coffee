sys = require('sys')

create_new_user_object = (msg, robot, user_id, user_name, room_id, message) ->
  user_object = { user_id: user_id, details: { user_name: user_name, last_msg_room_id : room_id, messages : [] } }
  user_object.details.messages.push message
  robot.brain["user_data"].push user_object

module.exports = (robot) ->
  robot.hear /(.*)/i, (msg) ->
    user_id = msg.message.user.id.toString()
    user_name = msg.message.user.name
    room_id = msg.message.user.room_id
    message = msg.message.text

    if robot.brain["user_data"]
      user_object = user for user in robot.brain["user_data"] when user.user_id == user_id
      if user_object
        user_object.details.messages.push message
      else
        create_new_user_object(msg, robot, user_id, user_name, room_id, message)
    else
      robot.brain["user_data"] = []
      create_new_user_object(msg, robot, user_id, user_name, room_id, message)
