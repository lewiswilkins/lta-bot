showNextTram = (robot, res) ->
  robot.http("http://prod.ivtr-od.tpg.ch/v1/GetNextDepartures.json?key=kVAh74dmvw3YWedSeeV7&stopCode=CERN&destinationsCode=CAROUGE").get() (err, resp, body) ->
    if err
      res.send "Error."
      return
    output = JSON.parse body
    nextTram = output["departures"]
    nextOne = nextTram[0]    
    result = "The next tram to Carouge from CERN is in "
    time = nextOne["waitingTime"]
    result += "#{time} mins."
    res.reply result   

module.exports = (robot) ->
  robot.hear /when is the next tram/i, (res) ->
    showNextTram robot, res
    