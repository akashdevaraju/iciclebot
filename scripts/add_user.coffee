# Description:
#   Script to add users to the database
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   add user <user name>, <training status(1/0)>, <user id>
#
# Notes:
#   None
#
# Author:
#   VinayNadig

module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.hear /add user (.*), (.*), (.*)/i, (msg) ->
      user_name = msg.match[1].trim()
      has_training = Boolean(Number(msg.match[2].trim()))
      user_id = msg.match[3].trim()
      user_object = { user_id: user_id, details: { user_name: user_name, last_msg_room_id: null, last_updated_time: null , messages : [], has_training: has_training, do_not_bug: false, dob: null, email: null, trainings: [] } }
      existing_user = user for user in robot.brain.user_data when user.user_id == user_id
      if existing_user
        msg.send("Sorry, #{user_name} already exists.")
      else
        robot.brain.user_data.push user_object
        msg.send("#{user_name} successfully added")

    robot.hear /(.*)help add user(.*)/i, (msg) ->
      msg.send "Usage: add user <user name>, <training status(1/0)>, <user id>"
