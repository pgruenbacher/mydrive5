/**
 * # CSV Helpers
 */
 
/**
 * @method CSV Escape
 * @param  {String} field
 * @return {String}
 */
function csvEscape (field) {
  return '"' + String(field || "").replace(/"/g, '""') + '"';
}
/**
 * @method Array to Single CSV Row
 * @param  {Array}  array  A list of fields
 * @return {String} One row of a CSV file
 */
function array2csvRow (array) {
  return array.map(csvEscape).join(',')+'\n';
}
 
/**
 * @method Array to CSV
 * @param  {Array} array  An array of arrays (containing fields)
 * @return {String}       CSV representation
 */
function array2csv (array) {
  return array.map(array2csvRow).join('');
}
 
module.exports = {
  escape: csvEscape,
  rowFromArray: array2csvRow,
  fromArray: array2csv
};