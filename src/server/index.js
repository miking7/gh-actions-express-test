const express = require('express');
const { execFile } = require('child_process');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  const helloPath = path.join(__dirname, '..', '..', 'dist', 'hello');
  
  execFile(helloPath, (error, stdout, stderr) => {
    if (error) {
      console.error('Error executing C program:', error);
      return res.status(500).json({ error: 'Internal server error' });
    }
    
    if (stderr) {
      console.error('C program stderr:', stderr);
    }
    
    res.send(stdout);
  });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
