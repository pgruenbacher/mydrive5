'use strict';

module.exports = function(sequelize, DataTypes) {
  var Image=sequelize.define('Image', {
    _id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    name: DataTypes.STRING,
    imageIdentifier:DataTypes.STRING,
    mimetype: DataTypes.STRING,
    active: DataTypes.BOOLEAN,
    extension: DataTypes.STRING,
    truncated: DataTypes.BOOLEAN,
    size: DataTypes.INTEGER,
    path: DataTypes.STRING,
    urlPath: DataTypes.STRING,
    encoding: DataTypes.STRING,
    originalName: DataTypes.STRING
  });
  Image.hasOne(Image,{as:'Thumbnail'});
  Image.belongsTo(Image,{as:'Original'});
  return Image;
};
