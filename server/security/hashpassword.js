const reverseAlphabetMap = {
  a: "h",
  b: "g",
  c: "f",
  d: "e",
  e: "d",
  f: "c",
  g: "b",
  h: "a",
  i: "r",
  j: "p",
  k: "q",
  l: "n",
  m: "o",
  n: "l",
  o: "m",
  p: "j",
  q: "k",
  r: "i",
  s: "z",
  t: "y",
  u: "x",
  v: "w",
  w: "v",
  x: "u",
  y: "t",
  z: "s",
  A: "H",
  B: "G",
  C: "F",
  D: "E",
  E: "D",
  F: "C",
  G: "B",
  H: "A",
  I: "R",
  J: "P",
  K: "Q",
  L: "N",
  M: "O",
  N: "L",
  O: "M",
  P: "J",
  Q: "K",
  R: "I",
  S: "Z",
  T: "Y",
  U: "X",
  V: "W",
  W: "V",
  X: "U",
  Y: "T",
  Z: "S"
};

const reverseNumberMap = {
  0: "7",
  1: "6",
  2: "4",
  3: "0",
  4: "2",
  5: "8",
  6: "5",
  7: "6",
  8: "9",
  9: "1",
};

const SECRET_KEY = "?w[q/;h.<pHC0ZC.:mR$Y9/'7Hh)$5";

const mapChar = (char, index) => {
  const keyChar = SECRET_KEY[index % SECRET_KEY.length];

  let shiftValue = 0;
  if (/[a-zA-Z]/.test(keyChar)) {
    shiftValue = keyChar.charCodeAt(0) - (keyChar === keyChar.toLowerCase() ? 97 : 65); // a=0, A=0
  } else if (/[0-9]/.test(keyChar)) {
    shiftValue = parseInt(keyChar, 10);
  }

  if (/[a-z]/.test(char)) {  
    const mappedChar = reverseAlphabetMap[char] || char;
    let shiftedCharCode =
      ((mappedChar.charCodeAt(0) - 97 + shiftValue) % 26) + 97; // a-z
    let shiftedChar = String.fromCharCode(shiftedCharCode);
    return shiftedChar;
  } else if (/[A-Z]/.test(char)) {  
    const mappedChar = reverseAlphabetMap[char] || char;
    let shiftedCharCode =
      ((mappedChar.charCodeAt(0) - 65 + shiftValue) % 26) + 65; // A-Z
    let shiftedChar = String.fromCharCode(shiftedCharCode);
    return shiftedChar;
  } else if (/[0-9]/.test(char)) {
    let mappedDigit = reverseNumberMap[char] || char;
    let numericValue = parseInt(mappedDigit, 10);
    numericValue = (numericValue + shiftValue) % 9;
    numericValue = numericValue === 0 ? 9 : numericValue;
    return numericValue.toString();
  } else {
    return char;
  }
};


const passwordHashing = (password) => {
  let hash = "";

  for (let i = 0; i < password.length; i++) {
    const char = password[i];
    const hashedChar = mapChar(char, i);
    hash += hashedChar;
  }

  hash = hash.split("").reverse().join("") + "x";

  return hash;
};

// let plainText = "Test1234Password123";
// let hashedPassword = passwordHashing(plainText);
// console.log("Plain Text:", plainText);
// console.log("Hashed Password:", hashedPassword);

module.exports = { passwordHashing };
