'use strict';

var mongoose = require('mongoose-bird')();
var Schema = mongoose.Schema;

var SubscriberSchema = new Schema({
  firstName:String,
  lastName:String,
  email:String,
  street:String,
  city:String,
  zip:Number,
  state:String
});

SubscriberSchema.statics.csvHeader= function(){
  return [
  'Email'
  ];
}
SubscriberSchema.methods.mapToCSV=function() {
  return [
    this.email
  ];
}
module.exports = mongoose.model('Subscriber', SubscriberSchema);
