(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

var url = window.location.href;
var domain = url.replace(/^\w+:\/\//, "").replace(/\/.*$/gi,"").toLowerCase();
if(domain == 'kdr2.com') {
    ga('create', 'UA-45424100-1', 'kdr2.com');
} else {
    ga('create', 'UA-45630119-1', 'mindniche.com');
}
ga('send', 'pageview');