@assert = (cond, msg) ->
  throw(msg) unless cond

@Races = new Meteor.Collection("races")
@Racers = new Meteor.Collection("racers")
@RaceParticipants = new Meteor.Collection("race_participants")
@States = new Meteor.Collection("states")
@Sequences = new Meteor.Collection("sequences")

@RaceStatuses =
  ['waiting_for_racers',
   'started',
   'abandoned',
   'finished']

@RacerStatuses =
  ['pending',
   'ready',
   'started',
   'ejected',
   'exited']