Template.race.helpers
  race: ->
    Utils.currentRace()

  lastValid: ->
    Session.get 'lastValid'

  inRace: ->
    Session.get('raceKey')

  isParticipating: ->
    Utils.isParticipating()

  isPending: ->
    participant = Utils.currentParticipant(true)
    participant.state is 'pending'

  participants: ->
    RaceParticipants.find()

Template.race.rendered = ->
  raceKey = Router.current().state.get('raceKey')
  Session.set('raceKey', raceKey)

  Meteor.subscribe 'race', raceKey
  Meteor.subscribe 'racers', raceKey
  Meteor.subscribe 'raceParticipants', raceKey, ->
    participantsCursor = RaceParticipants.find()
    participantsCursor.observe
      added: (participant) ->
        unless Utils.isRacer participant.racerKey
          Utils.redrawParticipant participant

      changed: (participant) ->
        unless Utils.isRacer participant.racerKey
          Utils.redrawParticipant participant

  Meteor.subscribe 'sequences', raceKey

  if Utils.isParticipating()
    $('#message').focus()

Template.race.events
  'click .ready-button': (e) ->
    Utils.readyUp()

  'click .leave-button': (e) ->
    Utils.leaveRace()

  'click .join-race-button': (e) ->
    Session.set 'lastValid', ''
    Meteor.call 'joinRace', Utils.participantPointer()

  'keypress :text': (e) ->
    charCode = e.which || e.keyCode
    Utils.validateSequence(charCode)

  'keydown :text': (e) ->
    return if $(e.currentTarget).val().length < 1
    charCode = e.which || e.keyCode
    Utils.validateSequence(charCode)

Template.race_participant.helpers
  isCurrentRacer: (racerKey) ->
    Utils.isRacer racerKey

Template.race_participant.rendered = ->
  participant = RaceParticipants.findOne(racerKey: @data.racerKey)
  Utils.redrawParticipant participant
