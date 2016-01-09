var fs = require('fs');

var file = fs.readFileSync('t.ml', 'utf-8');
var processed = file
  .split('(* pragma split *)')
  .map(chunk => 'Random.self_init ();;' + chunk)

processed.forEach((chunk, i) => {
  fs.writeFileSync('./' + i + '.ml', chunk, 'utf-8');
});
// console.log(processed[1]);
