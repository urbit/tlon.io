const express = require('express')
const helmet = require('helmet')
const app = express()

app.use(helmet())

app.use('/', express.static('dist', { extensions:['html'] }))

app.listen(3000, () => console.log('##########\ntlon.io\n0.0.0.0:3000\n##########\n'))

