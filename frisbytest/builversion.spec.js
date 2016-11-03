var frisby = require('frisby');

frisby.create('Get build version number')
    .get('http://localhost/nancysake/version')
    .addHeader('content-type', 'application/json')
    .addHeader('accept', '*/*')
    .expectStatus(200)
    .expectHeaderContains('content-type', 'application/json')
    .expectJSON({
        buildversion: '1.1'
    })
    .toss();