require './underscore.distance'

_ = root._ or require 'underscore'

gbg_lat = 57.7088951
gbg_lng = 11.9734794

random_places = [
  (name: 'Malmö', lat: 55.608635, lng: 13.0006313),
  (name: 'Alingsås', lat: 57.9268612, lng: 12.532494),
  (name: 'Stockholm', lat: 59.3299583, lng: 18.0572117),
  (name: 'Umeå', lat: 63.8300607, lng: 20.266814),
  (name: 'Varberg', lat: 57.1093763, lng: 12.2480832),
]

describe 'distsort unit tests', ->

  it 'should have imported correctly', ->
    expect(typeof _.distance).toEqual 'function'

  it 'shold measure distances with haversine correctly', ->
    gbg_alss = _.distance gbg_lat, gbg_lng, 57.9268612, 12.532494
    expect(Math.round gbg_alss).toEqual 41
    gbg_malm = _.distance gbg_lat, gbg_lng, 55.608635, 13.0006313
    expect(Math.round gbg_malm).toEqual 242

  it '.nearest() should sort a places list from nearest to farthest', ->
    nearest_ = _.pluck (_.nearest gbg_lat, gbg_lng, random_places), 'name'
    expect(nearest_).toEqual ['Alingsås',
                              'Varberg',
                              'Malmö',
                              'Stockholm',
                              'Umeå']

  it '.nearest() should sort a places list from nearest to farthest', ->
    farthest_ = _.pluck (_.farthest gbg_lat, gbg_lng, random_places), 'name'
    expect(farthest_).toEqual ['Umeå',
                               'Stockholm',
                               'Malmö',
                               'Varberg',
                               'Alingsås']
