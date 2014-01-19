same_day = (date1, date2) ->
  date1.month == date2.month and date1.year == date2.year and date1.date == date2.date

remind_training = (robot) ->
  console.log("in remind function")
  for user in robot.brain.user_data
    trainings = user.details.trainings
    trainings_length = trainings.length
    if trainings_length > 0
      console.log("okay user #{user.details.user_name} has some training")
      robot.reply({user: {name: user.details.user_name, room_id: process.env.HUBOT_TRAINING_ROOM_ID }}, "Please complete your self training") unless same_day((trainings[trainings_length - 1]).training_time, new Date)
    else
      console.log("user #{user.details.user_name} has no training")
      robot.reply({user: {name: user.details.user_name, room_id: process.env.HUBOT_TRAINING_ROOM_ID }}, "Please complete your self training")

check_env_vars = (robot) ->
  # TO-DO - Optimize
  unless process.env.HUBOT_TRAINING_FREQ?
    robot.logger.warning 'The HUBOT_TRAINING_FREQ environment variable is not set, defaulting to 5 PM Everyday.'
    process.env.HUBOT_TRAINING_FREQ = "0 39 22 * * *" # 5 PM Monday to Friday
  unless process.env.HUBOT_TRAINING_CHECK_INTERVAL?
    robot.logger.warning 'The HUBOT_TRAINING_CHECK_INTERVAL is not set, defaulting to 1 hour.'
    process.env.HUBOT_TRAINING_CHECK_INTERVAL = 1000 * 60
  unless process.env.HUBOT_TRAINING_ROOM_ID?
    robot.logger.warning 'The HUBOT_TRAINING_ROOM_ID is not set, defaulting to Team Icicle Room.'
    process.env.HUBOT_TRAINING_ROOM_ID = "52d1b8dc1d16bee74d00021e"

cronJob = require("cron").CronJob
module.exports = (robot) ->
  # check for environment variables
  check_env_vars robot
  new cronJob(process.env.HUBOT_TRAINING_FREQ, ->
    robot.reply {user: {name: "Everyone", room_id: process.env.HUBOT_TRAINING_ROOM_ID} }, "Please complete your self training and update here with link and topic"
    setTimeout ( ->
      remind_training robot
    ), process.env.HUBOT_TRAINING_CHECK_INTERVAL
  , null, true)
