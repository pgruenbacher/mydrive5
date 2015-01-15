/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Site = require('./site.model');

exports.register = function(socket) {
  Site.schema.post('save', function(doc) {
    console.log('site save',doc.menuItems[0].sub[0]);
    onSave(socket, doc);
  });
  Site.schema.post('remove', function(doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('site:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('site:remove', doc);
}
