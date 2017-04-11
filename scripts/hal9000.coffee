
module.exports = (robot) ->
    robot.respond /(bad robot|bad bot|wrong answer)/i, (res) ->
        res.send "_hides in a corner_"

    robot.respond /(right\?|am i right?)/i, (res) ->
        res.send "Of course, @" + res.message.user.name + "!"

    robot.respond /open the pod bay doors/i, (res) ->
        res.send "Sorry, @" + res.message.user.name + ". I'm a afraid I can't let you do that"

    robot.respond /(thank you|i'?m proud of you|nice work|good work|good bot|you'?re the best)/i, (res) ->
        res.send "You're welcome!"

    robot.respond /flip a coin/i, (res) ->
        res.send res.random ['heads', 'tails']

    robot.hear /test/i, (res) ->
        robot.http("https://r1d2.herokuapp.com/r1/tomorrow").get() (err, resp, body)->
            if err
                res.send "Error: #{err}"
                return
            res.reply body