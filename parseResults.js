// to see what the raw output is like, run ./_test.sh. We take the raw results,
// remove the noise, and reformat, in order to get absolute numbers
var extract = '(.+): (.+)\.';

function roundTo6thDecimal(num) {
  return Math.round(num * 1000000) / 1000000;
}

var output = require('fs').readFileSync('./temp', 'utf-8')
  .split('\n\n')
  .slice(1)
  .map(function(a) {
    var r = a.split('\n');
    // format:
    // [ 'Noise time: 0.011253.',
    //   'Noise time',
    //   '0.011253',
    //   index: 0,
    //   input: 'Noise time: 0.011253.' ]
    var noise = parseFloat(r[2].match(extract)[2]);
    var res1 = r[4].match(extract);

    var num1 = parseFloat(res1[2]);
    var name1 = res1[1];

    var res2 = r[6].match(extract);
    var num2 = parseFloat(res2[2]);
    var name2 = res2[1];

    var x = roundTo6thDecimal(num1 - noise);
    return r[0] + '\n' + name1 + ': ' + (x <= 0 ? '0 (too small)' : x) + '\n' + name2 + ': ' + roundTo6thDecimal(num2 - noise);
  })
  .join('\n\n');

console.log(output);
