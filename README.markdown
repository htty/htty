                     s         s
      .uef^"        :8        :8      ..
    :d88E          .88       .88     @L
    `888E         :888ooo   :888ooo 9888i   .dL
     888E .z8k -*8888888 -*8888888 `Y888k:*888.
     888E~?888L  8888      8888      888E  888I
     888E  888E  8888      8888      888E  888I
     888E  888E  8888      8888      888E  888I
     888E  888E .8888Lu=  .8888Lu=   888E  888I
     888E  888E ^%888*    ^%888*    x888N><888'
    m888N= 888>   'Y"       'Y"      "88"  888
     `Y"   888   __  .__                  88F
          J88" _/  |_|  |__   ____       98"
          @%   \   __\  |  \_/ __ \    ./"
        :"      |  | |   Y  \  ___/   ~`
                |__| |___|  /\___  >
                __________\/_____\/____________________
               /   |   \__    ___/\__    ___/\______   \
              /    ~    \|    |     |    |    |     ___/
              \    Y    /|    |     |    |    |    |
               \___|_  / |____|     |____|    |____|
               ______\/___________________.___.
               \__    ___/\__    ___/\__  |   |
                 |    |     |    |    /   |   |
                 |    |     |    |    \____   |
                 |____|     |____|    / ______|
                                      \/

[htty](http://htty.github.io) is a console application for interacting with web servers. It’s a fun way to explore web APIs and to learn the ins and outs of HTTP.

[![Travis CI build status]            ](http://travis-ci.org/htty/htty          "Travis CI build")
[![Gemnasium dependencies status]     ](http://gemnasium.com/htty/htty          "Gemnasium dependencies analysis")
[![Code Climate code quality]         ](http://codeclimate.com/github/htty/htty "Code Climate analysis")
[![Code Climate test coverage]        ](http://codeclimate.com/github/htty/htty "Code Climate analysis")
[![Inch inline documentation coverage]](http://inch-ci.org/github/htty/htty     "Inch inline documentation analysis")
[![RubyGems release]                  ](http://rubygems.org/gems/htty           "RubyGems release")

See what’s changed lately by reading the [project history](http://github.com/htty/htty/blob/master/History.markdown).

Installation
============

It couldn’t be much easier.

    $ gem install htty

You’ll need Ruby and RubyGems. It’s known to work well under OS X against Ruby v1.8.7, v1.9.2, v1.9.3, v2.0, and v2.1.

Features
========

* Intuitive, Tab-completed commands and command aliases
* Support for familiar HTTP methods _GET_, _POST_, _PUT_, and _DELETE_, as well as _PATCH_, _HEAD_, _OPTIONS_ and _TRACE_
* Support for HTTP Secure connections and HTTP Basic Authentication
* Automatic URL-encoding of userinfo, paths, query-string parameters, and page fragments
* Transcripts, both verbose and summary
* Scripting via _stdin_
* Dead-simple cookie handling and redirect following
* Built-in help

The things you can do with _htty_ are:

* **Build a request** — you can tweak the address, headers, cookies, and body at will
* **Send the request to the server** — after the request is sent, it remains unchanged in your session history
* **Inspect the server’s response** — you can look at the status, headers, cookies, and body in various ways
* **Review history** — a normal and a verbose transcript of your session are available at all times (destroyed when you quit _htty_)
* **Reuse previous requests** — you can refer to prior requests and copy them

Examples
========

Here are a few annotated _htty_ session transcripts to get you started.

Querying a web service
----------------------

This simple example shows how to explore a read-only web service with _htty_.

![ESV Bible Web Service example #1](http://htty.github.io/images/esvapi1.png)

You can point _htty_ at a complete or partial web URL. If you don’t supply a URL, http://0.0.0.0/ (port 80) will be used. You can vary the protocol scheme, userinfo, host, port, path, query string, and fragment as you wish.

The _htty_ shell prompt shows the address of the current request.

The `get` command is one of seven HTTP request methods supported. A concise summary of the response is shown when you issue a request.

You can follow redirects using the `follow` command. No request is made until you type a request command such as `get` or `post`.

![ESV Bible Web Service example #2](http://htty.github.io/images/esvapi2.png)

You can tweak segments of the address at will. Here we are navigating the site’s path hierarchy, which you can do with relative as well as absolute pathspecs.

![ESV Bible Web Service example #3](http://htty.github.io/images/esvapi3.png)

Here we add query-string parameters. Notice that characters that require URL encoding are automatically URL-encoded (unless they are part of a URL-encoded expression).

The `headers-response` and `body-response` commands reveal the details of a response.

![ESV Bible Web Service example #4](http://htty.github.io/images/esvapi4.png)

There was some cruft in the web service’s response (a horizontal line, a passage reference, verse numbers, a copyright stamp, and line breaks). We eliminate it by using API options provided by the web service we’re talking to.

We do a Julia Child maneuver and use the `address` command to change the entire URL, rather than add individual query-string parameters one by one.

Exit your session at any time by typing `quit` or hitting Ctrl-D.

Working with cookies
--------------------

The next example demonstrates <i>htty</i>’s HTTP Secure support and cookies features, as well as how to review and revisit past requests.

![Google example #1](http://htty.github.io/images/google1.png)

The _https://_ scheme and port 443 imply each other, just as the _http://_ scheme and port 80 imply each other. If you omit the scheme or the port, it will default to the appropriate value.

Notice that when cookies are offered in a response, a bold asterisk (it looks like a cookie) appears in the response summary. The same cookie symbol appears next to the _Set-Cookie_ header when you display response headers.

![Google example #2](http://htty.github.io/images/google2.png)

The `cookies-use` command copies cookies out of the response into the next request. The cookie symbol appears next to the _Cookie_ header when you display request headers.

![Google example #3](http://htty.github.io/images/google3.png)

An abbreviated history is available through the `history` command. Information about requests in the history includes request method, URL, number of headers (and a cookie symbol, if cookies were sent), and the size of the body. Information about responses in the history includes response code, number of headers (and a cookie symbol, if cookies were received), and the size of the body.

Note that history contains only numbered HTTP request and response pairs, not a record of all the commands you enter.

The `reuse` command makes a copy of the headers and body of an earlier request for you to build on.

Understanding complex HTTP conversations at a glance using history
------------------------------------------------------------------

Now we’ll look at <i>htty</i>’s HTTP Basic Authentication support and learn how to display unabbreviated transcripts of _htty_ sessions.

Assume that we have the following Sinatra application listening on Sinatra’s default port, 4567.

``` ruby
require 'sinatra'

get '/all-good' do
  [200, [['Set-Cookie', 'foo=bar; baz']], 'Hello World!']
end

put '/huh' do
  [404, 'What?']
end

delete '/hurl' do
  [500, 'Barf!']
end

post '/submit-novel' do
  redirect '/all-good'
end
```

This application expects _GET_ and _POST_ requests and responds in various contrived ways.

![Sinatra application example #1](http://htty.github.io/images/sinatra1.png)

When you change the userinfo portion of the address, or the entire address, the appropriate HTTP Basic Authentication header is created for you automatically. Notice that characters that require URL encoding are automatically URL-encoded (unless they are part of a URL-encoded expression).

When userinfo is supplied in a request, a bold mercantile symbol ( _@_ ) appears next to the resulting _Authorization_ header when you display request headers (see below).

Type `body-set` to enter body data, and terminate it by entering two consecutive blank lines, or by hitting Ctrl-D. The body will only be sent for _POST_ and _PUT_ requests. The appropriate _Content-Length_ header is created for you automatically (see below).

Different response codes are rendered with colors that suggest their meaning:

* Response codes between 200 and 299 appear <span style="background-color: green; color: black; font-weight: bold; padding: 0 0.25em 0 0.25em;">black on green</span> to indicate success
* Response codes between 300 and 399 appear <span style="background-color: darkblue; color: white; font-weight: bold; padding: 0 0.25em 0 0.25em;">white on blue</span> to indicate redirection
* Response codes between 400 and 499 appear <span style="background-color: darkred; color: white; font-weight: bold; padding: 0 0.25em 0 0.25em;">white on red</span> to indicate failure
* Response codes between 500 and 599 appear <span style="background-color: yellow; color: black; font-weight: bold; padding: 0 0.25em 0 0.25em; text-decoration: blink;">flashing black on yellow</span> to indicate a server error

![Sinatra application example #2](http://htty.github.io/images/sinatra2.png)

As with the abbreviated history demonstrated earlier, verbose history shows a numbered list of requests and the responses they elicited. All information exchanged between client and server is shown.

Getting help
------------

You can learn how to use _htty_ commands from within _htty_.

![htty’s built-in help](http://htty.github.io/images/help.png)

The `help` command takes an optional argument of the abbreviated or full name of a command.

Contributing
============

Report defects and feature requests on [GitHub Issues](http://github.com/htty/htty/issues).

Your patches are welcome, and you will receive attribution here for good stuff. Fork [the official _htty_ repository](http://github.com/htty/htty "htty’s ‘htty’ repository at GitHub") and send a pull request.

News and information
====================

Stay in touch with the _htty_ project by following [@get_htty](http://twitter.com/get_htty "get_htty at Twitter") on Twitter.

You can also get help in the [#htty channel on Freenode](http://webchat.freenode.net/?channels=htty).

Credits
=======

The author, [Nils Jonsson](mailto:htty@nilsjonsson.com), owes a debt of inspiration to the [_http-console_](http://github.com/cloudhead/http-console) project.

Thanks to [contributors](http://github.com/htty/htty/contributors "htty contributors at GitHub") (in alphabetical order):

* Pascal Borreli ([pborreli](http://github.com/pborreli "pborreli at GitHub"))
* Rob Dawson (ephox-rob/[rojotek](http://github.com/rojotek "rojotek at GitHub"))
* Bo Frederiksen ([bofrede](http://github.com/bofrede "bofrede at GitHub"))
* Johannes Gorset ([jgorset](http://github.com/jgorset "jgorset at GitHub"))
* Gabriele Lana ([gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub"))
* Carson McDonald ([carsonmcdonald](http://github.com/carsonmcdonald "carsonmcdonald at GitHub"))
* Sam Nguyen ([dtjm](http://github.com/dtjm "dtjm at GitHub"))
* Robert Pitts ([rbxbx](http://github.com/rbxbx "rbxbx at GitHub"))
* Matt Sanders ([nextmat](http://github.com/nextmat "nextmat at GitHub"))
* [vijay-v](http://github.com/vijay-v "vijay-v at GitHub")

License
=======

Released under the [MIT License](http://github.com/htty/htty/blob/master/License.markdown).

[Travis CI build status]:             https://secure.travis-ci.org/htty/htty.png?branch=master
[Gemnasium dependencies status]:      https://gemnasium.com/htty/htty.png
[Code Climate code quality]:          https://codeclimate.com/github/htty/htty.png
[Code Climate test coverage]:         https://codeclimate.com/github/htty/htty/coverage.png
[Inch inline documentation coverage]: http://inch-ci.org/github/htty/htty.png
[RubyGems release]:                   https://badge.fury.io/rb/htty.png
