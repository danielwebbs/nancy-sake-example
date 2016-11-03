var request = require('request-promise');
var run = require('gulp-run'); 
var gulp = require('gulp');

gulp.task('hello-world', function() {
  return run('echo Hello World').exec()    // prints "Hello World\n". 
    .pipe(gulp.dest('output'))      // writes "Hello World\n" to output/echo. 
})

// describe('Users factory', function() {
//   it('has a dummy spec to test 2 + 2', function() {
//     // An intentionally failing test. No code within expect() will never equal 4.
//     expect(4).toEqual(4);
//   });
// });

// describe('test nancysake api', function () {
//         var options = {
//             uri: 'http://localhost/nancysake/version'
//         }
//         request(options)
//             .then(function(data) {
//                 console.log("got value")
//                 console.log(data);
//                   it('should return the build version of the api', function () {
//                       expect(data).toEqual("1.2")
//                 })
                
//             })
//             .catch(function (err) {
//                 console.log(err);
//             });

// })