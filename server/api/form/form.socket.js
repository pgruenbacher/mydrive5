/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Form = require('./form.model');

exports.register = function(socket) {
  Form.schema.post('save', function(doc) {
    onSave(socket, doc);
  });
  Form.schema.post('remove', function(doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('form:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('form:remove', doc);
}
