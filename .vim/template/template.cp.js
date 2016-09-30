'use strict';

Main((input) => {
});

function readLine(input, N = 1) {
    return input.splice(0, N);
}

function Main(main) {
  let input = '';
  const sin = process.stdin;

  sin.resume();
  sin.setEncoding('utf8');
  sin.on('data', chunk => input += chunk);
  sin.on('end', () => main(input.trim().split('\n').map(line => line.split(' '))));
}

