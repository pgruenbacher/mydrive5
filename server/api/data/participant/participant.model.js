'use strict';

var mongoose = require('mongoose-bird')();
var Schema = mongoose.Schema;

var ParticipantSchema = new Schema({
  name: String,
  info: String,
  active: Boolean
});

module.exports = mongoose.model('Participant', ParticipantSchema);
