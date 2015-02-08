Template.race.helpers
  inRace: ->
    Session.get('raceKey')

Template.race.rendered = ->
  raceKey = Router.current().state.get('raceKey')
  Session.set('raceKey', raceKey)

  Meteor.subscribe "race", raceKey
  Meteor.subscribe "racers", raceKey
  Meteor.subscribe "raceParticipants", raceKey
  Meteor.subscribe "sequences", raceKey
