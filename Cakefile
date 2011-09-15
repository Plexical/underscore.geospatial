fs = require 'fs'
path = require 'path'
coffee = require 'coffee-script'

task 'compile', 'Compile CoffeeScript sources of underscore.geospatial', ->
  source = fs.readFileSync 'underscore.geospatial.coffee', 'utf-8'
  fs.writeFileSync 'underscore.geospatial.js', coffee.compile(source)
