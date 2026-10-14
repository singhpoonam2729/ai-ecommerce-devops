
const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Home endpoint
app.get("/", (req, res) => {
  res.json({
    message: "AI E-Commerce DevOps Platform",
    status: "running",
    version: "1.0.0"
  });
});

// Health check for Docker and Kubernetes
app.get("/health", (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString()
  });
});

// Sample products
app.get("/products", (req, res) => {
  res.json([
    { id: 1, name: "Laptop", price: 55000 },
    { id: 2, name: "Headphones", price: 2500 },
    { id: 3, name: "Keyboard", price: 1500 }
  ]);
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Application running on port ${PORT}`);
});

if (require.main === module) {
  app.listen(PORT, "0.0.0.0", () => {
    console.log(`Application running on port ${PORT}`);
  });
}

module.exports = app;

