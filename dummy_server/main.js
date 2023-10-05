const express = require("express");
const app = express();

app.use(express.json());

// Define the /search endpoint
app.post("/search", (req, res) => {
  // Get the query and number of results from the request parameters

  console.log("request body");

  const { query, count } = req.body;
  console.log(query);
  console.log(count);

  // Convert the number of results to an integer
  const numResults = parseInt(count);

  // Hardcoded data
  const data = Array.from({ length: numResults }, (_, i) => `Result ${i + 1}`);

  // Simulate the time taken for the query (in milliseconds)
  const timeTaken = Math.floor(Math.random() * 1000);

  // Return the data and time taken as JSON response
  res.json({ data, timeTaken });
});

// Start the server
app.listen(3000, () => {
  console.log("Dummy API server is running on port 3000");
});
