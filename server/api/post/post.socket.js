/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Post = require('../../sqldb').Post;

exports.register = function(socket) {
  Post.hook('afterCreate', function(doc, fields, fn) {
    onSave(socket, doc);
    fn(null);
  });
  Post.hook('afterUpdate', function(doc, fields, fn) {
    onSave(socket, doc);
    fn(null);
  });
  Post.hook('afterDestroy', function(doc, fields, fn) {
    onRemove(socket, doc);
    fn(null);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('post:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('post:remove', doc);
}
