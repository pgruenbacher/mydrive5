'use strict';


module.exports = function(sequelize, DataTypes) {
  var Post=sequelize.define('Post', {
    _id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    title: DataTypes.STRING,
    subTitle: DataTypes.STRING,
    active: DataTypes.BOOLEAN,
    publishedAt:DataTypes.DATE,
    content:DataTypes.BLOB
  });
  
  return Post;
};
