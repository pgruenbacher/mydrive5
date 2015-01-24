/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Custom = require('./custom.model');

exports.register = function(socket) {
  Custom.schema.post('save', function(doc) {
    onSave(socket, doc);
  });
  Custom.schema.post('remove', function(doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('custom:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('custom:remove', doc);
}
