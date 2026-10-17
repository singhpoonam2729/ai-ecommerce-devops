
const express = require("express");
const client = require("prom-client");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Prometheus metrics
const register = new client.Registry();
client.collectDefaultMetrics({ register });

const httpRequests = new client.Counter({
  name: "http_requests_total",
  help: "Total number of HTTP requests",
  labelNames: ["method", "route", "status_code"],
  registers: [register],
});

app.use((req, res, next) => {
  if (req.path === "/metrics") return next();

  res.on("finish", () => {
    httpRequests.inc({
      method: req.method,
      route: req.route?.path || req.path,
      status_code: String(res.statusCode),
    });
  });

  next();
});

app.get("/", (req, res) => {
  res.json({
    message: "AI E-Commerce DevOps Platform",
    status: "running",
    version: "1.0.0",
  });
});

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
  });
});

app.get("/products", (req, res) => {
  res.json([
    { id: 1, name: "Laptop", price: 55000 },
    { id: 2, name: "Headphones", price: 2500 },
    { id: 3, name: "Keyboard", price: 1500 },
  ]);
});

app.get("/metrics", async (req, res) => {
  res.set("Content-Type", register.contentType);
  res.end(await register.metrics());
});

if (require.main === module) {
  app.listen(PORT, "0.0.0.0", () => {
    console.log(`Application running on port ${PORT}`);
  });
}

module.exports = app;
