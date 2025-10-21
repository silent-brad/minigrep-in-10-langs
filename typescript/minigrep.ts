/**
 * Minigrep in TypeScript
 */

import fs from "fs";

// Get args
const file = process.argv[3];
const pattern = process.argv[2];
if (!file || !pattern) {
  console.error("Usage: minigrep.ts <pattern> <file>");
  process.exit(1);
}

// Get file contents
const contents = fs.readFileSync(file, "utf8");
if (!contents) {
  console.error("File not found");
  process.exit(1);
}

// Print matches
const lines = contents.split("\n");
lines.forEach((line, i) => {
  if (line.includes(pattern)) {
    console.log(`${i}: ${line}`);
  }
});

const numMatches = lines.filter((line) => line.includes(pattern)).length;
if (numMatches === 0) {
  console.log("No matches found");
  process.exit(1);
} else if (numMatches === 1) {
  console.log("Found 1 match");
} else {
  console.log(`Found ${numMatches} matches`);
}
