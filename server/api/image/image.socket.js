/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Image = require('../../sqldb').Image;

exports.register = function(socket) {
  Image.hook('afterCreate', function(doc, fields, fn) {
    onSave(socket, doc);
    fn(null);
  });
  Image.hook('afterUpdate', function(doc, fields, fn) {
    onSave(socket, doc);
    fn(null);
  });
  Image.hook('afterDestroy', function(doc, fields, fn) {
    onRemove(socket, doc);
    fn(null);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('image:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('image:remove', doc);
}
