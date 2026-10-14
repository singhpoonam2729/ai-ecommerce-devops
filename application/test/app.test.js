const request = require("supertest");
const { test } = require("node:test");
const assert = require("node:assert/strict");
const app = require("../app");

test("home endpoint returns running status", async () => {
  const response = await request(app).get("/");

  assert.equal(response.status, 200);
  assert.equal(response.body.status, "running");
});

test("health endpoint returns healthy status", async () => {
  const response = await request(app).get("/health");

  assert.equal(response.status, 200);
  assert.equal(response.body.status, "healthy");
});

test("products endpoint returns three products", async () => {
  const response = await request(app).get("/products");

  assert.equal(response.status, 200);
  assert.equal(response.body.length, 3);
});

