'use strict';

var mongoose = require('mongoose-bird')();
var Schema = mongoose.Schema;

var selectSchema = new Schema({
  name:String,
  value:String
});

var fieldSchema = new Schema({
  name: String,
  type: String,
  label: String,
  required: Boolean,
  id: String,
  format:String,
  minlength:Number,
  maxlength:Number,
  selects: [selectSchema]
});
var FormSchema = new Schema({
  title:String,
  fields:[fieldSchema],
  user: {
    _id:Number
  }
})

module.exports = mongoose.model('Form', FormSchema);
