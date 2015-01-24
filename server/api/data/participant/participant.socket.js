/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Participant = require('./participant.model');

exports.register = function(socket) {
  Participant.schema.post('save', function(doc) {
    onSave(socket, doc);
  });
  Participant.schema.post('remove', function(doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('participant:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('participant:remove', doc);
}
