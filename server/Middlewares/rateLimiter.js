const rateLimit = require("express-rate-limit");

const rateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5000,
  message: "Too many requests from this IP, please try again later.",
});

module.exports = rateLimiter;
