const express = require('express');

// Constants
const PORT = 3000;

// App
const app = express();
app.get('/', (req, res) => {  
  res.send('Hola Mundo!!!')
})

app.get('/:nombre', (req, res) => {  
  res.send(`Hola ${req.params.nombre}!`)
})

app.listen(PORT, (err) => {  
  console.log(`Server running on port ${PORT}`)
})