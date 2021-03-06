debug = require('debug')('adb:command')

Parser = require './parser'
Protocol = require './protocol'

class Command
  RE_SQUOT = /'/g

  constructor: (@connection) ->
    @parser = @connection.parser
    @protocol = Protocol

  execute: (callback) ->
    throw new Exception 'Missing implementation'

  _unexpected: (data) ->
    new Error "Unexpected response data: '#{data}'"

  _send: (data) ->
    encoded = Protocol.encodeData data
    debug "Send '#{encoded}'"
    @connection.write encoded
    return this

  _escape: (arg) ->
    switch typeof arg
      when 'number'
        arg
      else
        "'" + arg.toString().replace(RE_SQUOT, "'\"'\"'") + "'"

module.exports = Command
