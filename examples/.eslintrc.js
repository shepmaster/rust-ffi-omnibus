module.exports = {
  "extends": [
    "eslint:recommended",
    "google",
  ],
  "env": {
    "node": true,
    "es6": true,
  },
  "rules": {
    // Prefer the better-behaved ES6 variable declarations
    "no-var": "error",
    "prefer-const": "error",
    // The FFI library is outside of our control
    "new-cap": ["error", {
      "capIsNewExceptions": ["Library"],
    }],
    // We are doing interop with Rust code which is exposed with
    // snake_case
    "camelcase": ["error", {
      "properties": "never",
    }],
    // I prefer to have uniform commas
    "comma-dangle": "off",
    // All examples work by printing
    "no-console": "off",
    // All the documentation is in the page
    "require-jsdoc": "off",
  }
};
