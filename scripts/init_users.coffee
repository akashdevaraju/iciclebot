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
#   init users
#
# Notes:
#   None
#
# Author:
#   VinayNadig

# Optimize later, there should be a better way to do this
users = [["Akash Devaraju", "true", "1413426"],["ibot icicle", "true", "1437290"],["Vinay Nadig", "true", "1485120"],["Abhishek Kumar", "true", "1535444"],["Anita Bharambe", "true", "1403808"],["Hitesh Mahajan", "true", "1479276"],["Nidhi Sarvaiya A", "false", "1402562"],["Pritish Mhapankar A", "false", "1402564"],["Ramesh Yadav", "false", "1402570"],["Rashmi Nair", "true", "1402580"],["Sailee Reddy", "true", "1403804"],["Sanjay Patel A", "false", "1402566"],["Shrivara K S", "true", "1460470"],["Smita Sreekanth", "false", "1402568"],["Vikrant Kamble", "true", "1403814"],["Aarti Kumawat", "false", "1405174"],["Akshay Takkar", "true", "1452740"],["Ankita Gupta", "false", "1526094"],["Avik Bhattacharya", "true", "1437120"],["Chandravati Gupta", "true", "1403812"],["Kavita Parmar", "true", "1448410"],["Mayuri Purohit", "false", "1435764"],["Praveen Wicliff A", "false", "1402560"],["Rachit Garg", "true", "1534022"],["Ramesh Yadav", "false", "1403806"],["Rohit Bhore", "true", "1434028"],["Sandeep Sargar", "true", "1403818"],["Sneha Kachroo", "true", "1404044"],["Vishnu Priya", "true", "1534024"]]


module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.hear /init users/i, (msg) ->
      for user in users
        user_id = user[2]
        user_name = user[0]
        has_training = user[1]
        user_object = { user_id: user_id, details: { user_name: user_name, last_msg_room_id: null, last_updated_time: null , messages : [], has_training: has_training, do_not_bug: false, dob: null, email: null, trainings: [] } }
        existing_user = user for user in robot.brain.user_data when user.user_id == user_id
        if existing_user
          msg.send("Sorry, #{user_name} already exists.")
        else
          robot.brain.user_data.push user_object
          msg.send("#{user_name} successfully added")
