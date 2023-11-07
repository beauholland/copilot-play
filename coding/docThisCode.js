// DEMO
// CTRL+I on highlighted text "/doc"

function sum(num) {
    if(num > 0) {
        return num + sum(num - 1);
    }
    else {
        return num;
    }
 }


const number = parseInt(prompt('Enter a positive integer: '));

const result = sum(number);

console.log(`The sum is ${result}`);

function addRange(num) {
    if(num > 0) {
        return num + addRange(num - 1);
    }
    else {
        return num;
    }
 }
 function addRandomNumbers(num) {
    if(num > 0) {
        return num + addRandomNumbers(num - 1);
    }
    else {
        return num;
    }
 }
 