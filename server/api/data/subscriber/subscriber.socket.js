/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Subscriber = require('./subscriber.model');

exports.register = function(socket) {
  Subscriber.schema.post('save', function(doc) {
    onSave(socket, doc);
  });
  Subscriber.schema.post('remove', function(doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('subscriber:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('subscriber:remove', doc);
}
