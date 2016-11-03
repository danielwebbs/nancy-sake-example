var request = require('request-promise');
var gulp = require('gulp-run'); 

gulp.task('hello-world', function() {
  return run('echo Hello World').exec()    // prints "Hello World\n". 
    .pipe(gulp.dest('output'))      // writes "Hello World\n" to output/echo. 
  ;
})

describe('Users factory', function() {
  it('has a dummy spec to test 2 + 2', function() {
    // An intentionally failing test. No code within expect() will never equal 4.
    expect(4).toEqual(4);
  });
});