'use strict';

var mongoose = require('mongoose-bird')();
var Schema = mongoose.Schema;
var slug = require('slug');

function isSlug(value){
  return /^[a-z0-9]+(?:-[A-Za-z0-9]+)*$/.test(value)
}


var SubSchema = new Schema({
  title:String,
  template: Schema.Types.Mixed
});

SubSchema.virtual('slug').get(function(){
  return slug(this.title);  
});
SubSchema.virtual('parentId').get(function(){
  // console.log(this.parent());
  return this.parent().id
});
var MenuSchema = new Schema({
  title:String,
  sub:[SubSchema],
  template: Schema.Types.Mixed
});

MenuSchema.virtual('slug').get(function(){
  return slug(this.title).toLowerCase();
});

var SiteSchema = new Schema({
  siteName: String,
  user: {
    _id:Number
  },
  domainName:{
    type:String,
    unique:true,
    validate:[isSlug,'not valid slug']
  },
  homePage:{
    title:String,
    template: Schema.Types.Mixed
  },
  menuItems:[MenuSchema],
  active: Boolean
});


SiteSchema.set('toJSON', {
   virtuals: true
});

module.exports = mongoose.model('Site', SiteSchema);
