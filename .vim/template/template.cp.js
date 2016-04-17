'use strict';

Main((input) => {
    input = input.trim().split('\n');
});

function Main(main) {
  let input = '';
  const sin = process.stdin;

  sin.resume();
  sin.setEncoding('utf8');
  sin.on('data', chunk => input += chunk);
  sin.on('end', () => main(input));
}
