# Decide where to export functions to.
root = exports ? @

# This module depends on Underscore.js to not become too large.
_ = root._ or require 'underscore'

# Degrees need to be converted to Radians
rad = (n) -> n * Math.PI / 180
mrad = _.memoize (n) -> rad n

# Haversine formula
# http://en.wikipedia.org/wiki/Haversine_formula
distance = (lat1, lng1, lat2, lng2) ->
  dLat = rad(lat2-lat1)
  dLng = rad(lng2-lng1)
  lat1 = mrad(lat1)
  lat2 = rad(lat2)

  a = (Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.sin(dLng/2) * Math.sin(dLng/2) * Math.cos(lat1) * Math.cos(lat2))

  6371 * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

# Assumes an iterable object with elements that have `.lat` and
# `.lng` attributes. See specs for examples.
nearest = (lat, lng, iterable) ->
  _.sortBy iterable, (p) -> distance lat, lng, p.lat, p.lng

# Same as `.nearest()`, but reverse order.
farthest = (lat, lng, iterable) ->
  _.sortBy iterable, (p) -> - distance lat, lng, p.lat, p.lng

_.mixin
  distance: distance
  nearest: nearest
  farthest: farthest
