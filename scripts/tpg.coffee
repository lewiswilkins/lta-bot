showNextTram = (robot, res) ->
  robot.http("http://prod.ivtr-od.tpg.ch/v1/GetNextDepartures.json?key=kVAh74dmvw3YWedSeeV7&stopCode=CERN&destinationsCode=CAROUGE").get() (err, resp, body) ->
    if err
      res.send "Error."
      return
    output = JSON.parse body
    departures = output["departures"]
    nextDeparture = departures[0]    
    result = "The next tram to Carouge from CERN is in "
    time = nextDeparture["waitingTime"]
    result += "#{time} mins."
    if time<7
      result += " You may as well have another beer, I doubt you'll make it. The following tram is in "
      followingDeparture = departures[1]
      followingDepartureTime = followingDeparture["waitingTime"]
      result += "#{followingDepartureTime} mins."
      
      
    res.reply result   

GetNextDepartures = (robot, res, stopCode) ->
  robot.http("http://prod.ivtr-od.tpg.ch/v1/GetNextDepartures.json?key=kVAh74dmvw3YWedSeeV7&stopCode=#{stopCode}").get() (err, resp, body) ->
    if err
      res.send "Error."
      return
    output = JSON.parse body
    departures = output["departures"]
    stopName = output.stop.stopName
    result = "The next departures from #{stopName} are:\n"
    for dept, i in departures
      line = dept["line"]
      lineCode = line["lineCode"]
      destination = line["destinationName"]
      waitingTime = dept["waitingTime"]
      if waitingTime == "&gt;1h"
        result += "Line #{lineCode} to #{destination} in >1hr.\n"
      else if waitingTime == "no more"
        result += "Line #{lineCode} to #{destination} is finished for the day.\n"
      else
        result += "Line #{lineCode} to #{destination} in #{waitingTime} mins.\n"
    res.reply result 
           
GetNextDeparturesToDestination = (robot, res, stopCode, destinationsCode) ->
  robot.http("http://prod.ivtr-od.tpg.ch/v1/GetNextDepartures.json?key=kVAh74dmvw3YWedSeeV7&stopCode=#{stopCode}&destinationCode=#{destinationCode}").get() (err, resp, body) ->
    if err
      res.send "Error."
      return
      
     


module.exports = (robot) ->
  robot.hear /when is the next tram/i, (res) ->
    showNextTram robot, res
    
  robot.hear /what are the departures from (.*)/i, (res) ->
    stopCode = res.match[1]
    GetNextDepartures robot, res, stopCode 