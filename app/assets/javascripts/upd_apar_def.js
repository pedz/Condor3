$(document).ready(function () {
    $.when( $.get('/assets/t1.html', null, null, 'html') ).done(function () {
	console.log('done');
    }).fail(function (a, b, c) {
	console.log(a, b, c);
    });
});
