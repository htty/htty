# Examples

Here are a few annotated _htty_ session transcripts to get you started.

## Querying a web service

This simple example shows how to explore a read-only web service with _htty_.

### ESV Bible Web Service example #1

    $ htty esvapi.org
    *** Welcome to htty, the HTTP TTY. Heck To The Yeah!
    http://esvapi.org/> get
    *** Type fol[low] to follow the 'Location' header received in the response
    301 Moved Permanently -- 6 headers -- 373-character body
    http://esvapi.org/> follow
    http://www.esvapi.org/> 

You can point _htty_ at a complete or partial web URL. If you don’t supply a URL, http://0.0.0.0/ (port 80) will be used. You can vary the protocol scheme, userinfo, host, port, path, query string, and fragment as you wish.

The _htty_ shell prompt shows the address of the current request.

The `get` command is one of seven HTTP request methods supported. A concise summary of the response is shown when you issue a request.

You can follow redirects using the `follow` command. No request is made until you type a request command such as `get` or `post`.

### ESV Bible Web Service example #2

    http://www.esvapi.org/> cd /v2/rest/nonexistent/path
    http://www.esvapi.org/v2/rest/nonexistent/path> get
    404 Not Found -- 5 headers -- 369-character body
    http://www.esvapi.org/v2/rest/nonexistent/path> cd ../../passageQuery
    http://www.esvapi.org/v2/rest/passageQuery> 

You can tweak segments of the address at will. Here we are navigating the site’s path hierarchy, which you can do with relative as well as absolute pathspecs.

### ESV Bible Web Service example #3

    http://www.esvapi.org/v2/rest/passageQuery> query-set key IP
    http://www.esvapi.org/v2/rest/passageQuery?key=IP> query-set passage 'Luke 5:3-6'
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6> query-set output-format plain-text
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text> get
    200 OK -- 10 headers -- 565-character body
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text> body
    =======================================================
    Luke 5:3-6
        [3]Getting into one of the boats, which was Simon's, he asked him to
    put out a little from the land. And he sat down and taught the people
    from the boat. [4]And when he had finished speaking, he said to Simon,
    "Put out into the deep and let down your nets for a catch." [5]And Simon
    answered, "Master, we toiled all night and took nothing! But at your word
    I will let down the nets." [6]And when they had done this, they enclosed
    a large number of fish, and their nets were breaking. (ESV)
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text> 

Here we add query-string parameters. Notice that characters that require URL encoding are automatically URL-encoded (unless they are part of a URL-encoded expression).

The `headers-response` and `body-response` commands reveal the details of a response.

### ESV Bible Web Service example #4

    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text> address http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text&include-passage-horizontal-lines=false&include-passage-references=false&include-verse-numbers=false&include-short-copyright=false&line-length=0
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text&include-passage-horizontal-lines=false&include-passage-references=false&include-verse-numbers=false&include-short-copyright=false&line-length=0> get
    200 OK -- 9 headers -- 474-character body
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text&include-passage-horizontal-lines=false&include-passage-references=false&include-verse-numbers=false&include-short-copyright=false&line-length=0> body
    Getting into one of the boats, which was Simon's, he asked him to put out a little from the land. And he sat down and taught the people from the boat. And when he had finished speaking, he said to Simon, "Put out into the deep and let down your nets for a catch." And Simon answered, "Master, we toiled all night and took nothing! But at your word I will let down the nets." And when they had done this, they enclosed a large number of fish, and their nets were breaking.
    http://www.esvapi.org/v2/rest/passageQuery?key=IP&passage=Luke%205:3-6&output-format=plain-text&include-passage-horizontal-lines=false&include-passage-references=false&include-verse-numbers=false&include-short-copyright=false&line-length=0> quit
    *** Happy Trails To You!
    $ 

There was some cruft in the web service’s response (a horizontal line, a passage reference, verse numbers, a copyright stamp, and line breaks). We eliminate it by using API options provided by the web service we’re talking to.

We do a Julia Child maneuver and use the `address` command to change the entire URL, rather than add individual query-string parameters one by one.

Exit your session at any time by typing `quit` or hitting Ctrl-D.

## Working with cookies

The next example demonstrates <i>htty</i>’s HTTP Secure support and cookies features, as well as how to review and revisit past requests.

### Google example #1

    https://www.google.com/search?q=Ruby+programming+language> get
    *** Type cookies-u[se] to use cookies offered in the response
    *** Type fol[low] to follow the 'Location' header received in the response
    302 Found -- 8 headers* -- 260-character body
    https://www.google.com/search?q=Ruby+programming+language> headers-response
            Location: https://encrypted.google.com/search?q=Ruby+programming+language
       Cache-Control: private
        Content-Type: text/html; charset=UTF-8
         Set-Cookie:* O=HAI.; I=CAN; HAS=PRAIVASY?; G00G=RULZ!
                Date: Tue, 28 Sep 2010 19:57:23 GMT
              Server: gws
      Content-Length: 260
    X-Xss-Protection: 1; mode=block
    https://www.google.com/search?q=Ruby+programming+language> follow
    https://encrypted.google.com/search?q=Ruby+programming+language> 

The _https://_ scheme and port 443 imply each other, just as the _http://_ scheme and port 80 imply each other. If you omit the scheme or the port, it will default to the appropriate value.

Notice that when cookies are offered in a response, a bold asterisk (it looks like a cookie) appears in the response summary. The same cookie symbol appears next to the _Set-Cookie_ header when you display response headers.

### Google example #2

    https://encrypted.google.com/search?q=Ruby+programming+language> headers-request
    User-Agent: htty/1.1.0
    https://encrypted.google.com/search?q=Ruby+programming+language> cookies
    https://encrypted.google.com/search?q=Ruby+programming+language> cookies-use
    *** 4 cookies now in use
    https://encrypted.google.com/search?q=Ruby+programming+language> headers-request
    User-Agent: htty/1.1.0
       Cookie:* O=HAI.; I=CAN; HAS=PRAIVASY?; G00G=RULZ!
    https://encrypted.google.com/search?q=Ruby+programming+language> cookies
       O: HAI.
       I: CAN
     HAS: PRAIVASY?
    G00G: RULZ!
    https://encrypted.google.com/search?q=Ruby+programming+language> 

The `cookies-use` command copies cookies out of the response into the next request. The cookie symbol appears next to the _Cookie_ header when you display request headers.

### Google example #3

    https://encrypted.google.com/search?q=Ruby+programming+language> get
    200 OK -- 8 headers* -- 41111-character body
    https://encrypted.google.com/search?q=Ruby+programming+language> history
    1 GET https://www.google.com/search?q=Ruby+programming+language -- 1 header -- empty body
      302 Found -- 8 headers* -- 260-character body
    2 GET https://www.google.com/search?q=Ruby+programming+language -- 2 headers* -- empty body
      200 OK -- 8 headers* -- 41111-character body
    https://encrypted.google.com/search?q=Ruby+programming+language> headers-request
    User-Agent: htty/1.1.0
       Cookie:* O=HAI.; I=CAN; HAS=PRAIVASY?; G00G=RULZ!
    https://encrypted.google.com/search?q=Ruby+programming+language> reuse 1
    *** Using a copy of request #1
    https://encrypted.google.com/search?q=Ruby+programming+language> headers-request
    User-Agent: htty/1.1.0
    https://encrypted.google.com/search?q=Ruby+programming+language> 

An abbreviated history is available through the `history` command. Information about requests in the history includes request method, URL, number of headers (and a cookie symbol, if cookies were sent), and the size of the body. Information about responses in the history includes response code, number of headers (and a cookie symbol, if cookies were received), and the size of the body.

Note that history contains only numbered HTTP request and response pairs, not a record of all the commands you enter.

The `reuse` command makes a copy of the headers and body of an earlier request for you to build on.

## Understanding complex HTTP conversations at a glance using history

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

### Sinatra application example #1

    http://0.0.0.0:4567/all-good> get
    *** Type cookies-u[se] to use cookies offered in the response
    200 OK -- 6 headers* -- 12-character body
    http://0.0.0.0:4567/all-good> cookies-use
    *** 2 cookies now in use
    http://0.0.0.0:4567/all-good> cd /huh
    http://0.0.0.0:4567/huh> put
    404 Not Found -- 5 headers -- 5-character body
    http://0.0.0.0:4567/huh> userinfo-set htty@nilsjonsson.com secret
    http://htty%40nilsjonsson.com:secret@0.0.0.0:4567/huh> cd /hurl
    http://htty%40nilsjonsson.com:secret@0.0.0.0:4567/hurl> delete
    500 Internal Server Error -- 5 headers -- 5-character body
    http://htty%40nilsjonsson.com:secret@0.0.0.0:4567/hurl> cookies-remove-all
    http://htty%40nilsjonsson.com:secret@0.0.0.0:4567/hurl> userinfo-unset
    http://0.0.0.0:4567/hurl> body-set
    *** Enter two blank lines, or hit Ctrl-D, to signify the end of the body
    If a body
    
    meet a body
    
    comin' through the rye
    
    
    http://0.0.0.0:4567/hurl> header-set Author 'J. D. Salinger'
    http://0.0.0.0:4567/hurl> cd /submit-novel
    http://0.0.0.0:4567/submit-novel> post
    *** Type fol[low] to follow the 'Location' header received in the response
    302 Found -- 6 headers -- empty body
    http://0.0.0.0:4567/submit-novel> 

When you change the userinfo portion of the address, or the entire address, the appropriate HTTP Basic Authentication header is created for you automatically. Notice that characters that require URL encoding are automatically URL-encoded (unless they are part of a URL-encoded expression).

When userinfo is supplied in a request, a bold mercantile symbol ( _@_ ) appears next to the resulting _Authorization_ header when you display request headers (see below).

Type `body-set` to enter body data, and terminate it by entering two consecutive blank lines, or by hitting Ctrl-D. The body will only be sent for _POST_ and _PUT_ requests. The appropriate _Content-Length_ header is created for you automatically (see below).

Different response codes are rendered with colors that suggest their meaning:

* Response codes between 200 and 299 appear <span style="background-color: green; color: black; font-weight: bold; padding: 0 0.25em 0 0.25em;">black on green</span> to indicate success
* Response codes between 300 and 399 appear <span style="background-color: darkblue; color: white; font-weight: bold; padding: 0 0.25em 0 0.25em;">white on blue</span> to indicate redirection
* Response codes between 400 and 499 appear <span style="background-color: darkred; color: white; font-weight: bold; padding: 0 0.25em 0 0.25em;">white on red</span> to indicate failure
* Response codes between 500 and 599 appear <span style="background-color: yellow; color: black; font-weight: bold; padding: 0 0.25em 0 0.25em; text-decoration: blink;">flashing black on yellow</span> to indicate a server error

### Sinatra application example #2

    http://0.0.0.0:4567/submit-novel> history-verbose
    1 GET http://0.0.0.0:4567/all-good -- 1 header -- empty body
    
    User-Agent: htty/1.1.0
    
    200 OK -- 6 headers* -- 12-character body
    
      Content-Type: text/html
    Content-Length: 12
            Server: WEBrick/1.3.1 (Ruby/1.9.3/2010-09-25)
              Date: Tue, 28 Sep 2010 21:10:58 GMT
        Connection: Keep-Alive
       Set-Cookie:* foo=bar; baz
    
    Hello World!
    ------------------------------------------------------------------------------
    2 PUT http://0.0.0.0:4567/huh -- 3 headers* -- empty body
    
        User-Agent: htty/1.1.0
    Content-Length: 0
           Cookie:* foo=bar; baz
    
    404 Not Found -- 5 headers -- 5-character body
    
      Content-Type: text/html
    Content-Length: 5
            Server: WEBrick/1.3.1 (Ruby/1.9.3/2010-09-25)
              Date: Tue, 28 Sep 2010 21:11:05 GMT
        Connection: Keep-Alive
    
    What?
    ------------------------------------------------------------------------------
    3 DELETE http://htty%40nilsjonsson.com:secret@0.0.0.0:4567/hurl -- 3 headers* -- empty body
    
        User-Agent: htty/1.1.0
           Cookie:* foo=bar; baz
    Authorization:@ Basic aHR0eUBuaWxzam9uc3NvbjpzZWNyZXQ=
    
    500 Internal Server Error -- 5 headers -- 5-character body
    
      Content-Type: text/html
    Content-Length: 5
            Server: WEBrick/1.3.1 (Ruby/1.9.3/2010-09-25)
              Date: Tue, 28 Sep 2010 21:12:17 GMT
        Connection: Keep-Alive
    
    Barf!
    ------------------------------------------------------------------------------
    4 POST http://0.0.0.0:4567/submit-novel -- 3 headers -- 46-character body
    
        User-Agent: htty/1.1.0
    Content-Length: 46
            Author: J. D. Salinger
    
    If a body
    
    meet a body
    
    comin' through the rye
    
    302 Found -- 6 headers -- empty body
    
      Content-Type: text/html
          Location: http://0.0.0.0:4567/all-good
    Content-Length: 0
            Server: WEBrick/1.3.1 (Ruby/1.9.3/2010-09-25)
              Date: Tue, 28 Sep 2010 21:13:44 GMT
        Connection: Keep-Alive
    http://0.0.0.0:4567/submit-novel> 

As with the abbreviated history demonstrated earlier, verbose history shows a numbered list of requests and the responses they elicited. All information exchanged between client and server is shown.

## Getting help

You can learn how to use _htty_ commands from within _htty_.

### <i>htty</i>’s built-in help

    http://0.0.0.0/> help
    
                                       Navigation
    
      a[ddress] ADDRESS                             Changes the address of the
                                                    request
      cd PATH                                       Alias for path[-set]
      fol[low]                                      Changes the address of the
                                                    request to the value of the
                                                    response's 'Location' header
      fragment-c[lear]                              Alias for
                                                    fragment-u[nset]
      fragment-s[et] FRAGMENT                       Sets the fragment of the
                                                    request's address
      fragment-u[nset]                              Removes the fragment from the
                                                    request's address
      history                                       Displays previous
                                                    request-response activity in
                                                    this session
      history-[verbose]                             Displays the details of previous
                                                    request-response activity in
                                                    this session
      ho[st-set] HOST                               Changes the host of the
                                                    request's address
      path[-set] PATH                               Changes the path of the
                                                    request's address
      por[t-set] PORT                               Changes the TCP port of the
                                                    request's address
      query-a[dd] NAME [VALUE [NAME [VALUE ...]]]   Adds query-string parameters to
                                                    the request's address
      query-c[lear]                                 Alias for
                                                    query-unset-[all]
      query-r[emove] NAME [VALUE]                   Removes query-string parameters
                                                    from the end of the request's
                                                    address
      query-s[et] NAME [VALUE [NAME [VALUE ...]]]   Sets query-string parameters in
                                                    the request's address
      query-unset NAME [VALUE]                      Removes query-string parameters
                                                    from the request's address
      query-unset-[all]                             Clears the query string of the
                                                    request's address
      r[euse] INDEX                                 Copies a previous request by the
                                                    index number shown in history
      sc[heme-set] SCHEME                           Changes the scheme (protocol
                                                    identifier) of the request's
                                                    address
      userinfo-c[lear]                              Alias for
                                                    userinfo-u[nset]
      userinfo-s[et] USERNAME [PASSWORD]            Sets the userinfo of the
                                                    request's address
      userinfo-u[nset]                              Removes the userinfo from the
                                                    request's address
    
                                   Building Requests
    
      body-c[lear]                                  Alias for body-u[nset]
      body-request                                  Displays the body of the request
      body-s[et]                                    Sets the body of the request
      body-u[nset]                                  Clears the body of the request
      cookie-a[dd] NAME [VALUE]                     Alias for cookies-a[dd]
      cookie-r[emove] NAME                          Alias for cookies-remove
      cookies                                       Displays the cookies of the
                                                    request
      cookies-a[dd] NAME [VALUE]                    Adds a cookie to the request
      cookies-c[lear]                               Alias for
                                                    cookies-remove-[all]
      cookies-remove NAME                           Removes from the request the
                                                    last cookie having a particular
                                                    name
      cookies-remove-[all]                          Removes all cookies from the
                                                    request
      cookies-u[se]                                 Uses cookies offered in the
                                                    response
      form                                          (Help for form is not
                                                    available)
      form-a[dd]                                    (Help for form-a[dd] is
                                                    not available)
      form-c[lear]                                  Alias for
                                                    form-remove-[all]
      form-remove                                   (Help for form-remove is
                                                    not available)
      form-remove-[all]                             (Help for
                                                    form-remove-[all] is not
                                                    available)
      header-s[et] NAME VALUE                       Alias for headers-s[et]
      header-u[nset] NAME                           Alias for headers-unset
      headers-c[lear]                               Alias for
                                                    headers-unset-[all]
      headers-req[uest]                             Displays the headers of the
                                                    request
      headers-s[et] NAME VALUE                      Sets a header of the request
      headers-unset NAME                            Removes a header of the request
      headers-unset-[all]                           Removes all headers from the
                                                    request
    
                                    Issuing Requests
    
      d[elete]                                      Alias for http-d[elete]
      g[et]                                         Alias for http-g[et]
      http-d[elete]                                 Issues an HTTP DELETE using the
                                                    current request
      http-g[et]                                    Issues an HTTP GET using the
                                                    current request
      http-h[ead]                                   Issues an HTTP HEAD using the
                                                    current request
      http-o[ptions]                                Issues an HTTP OPTIONS using the
                                                    current request
      http-po[st]                                   Issues an HTTP POST using the
                                                    current request
      http-pu[t]                                    Issues an HTTP PUT using the
                                                    current request
      http-t[race]                                  Issues an HTTP TRACE using the
                                                    current request
      pos[t]                                        Alias for http-po[st]
      pu[t]                                         Alias for http-pu[t]
    
                                  Inspecting Responses
    
      body[-response]                               Displays the body of the
                                                    response
      headers[-response]                            Displays the headers of the
                                                    response
      st[atus]                                      Displays the status of the
                                                    response
    
                                      Preferences
    
      ssl-verification                              Displays the preference for SSL
                                                    certificate verification
      ssl-verification-of[f]                        Disables SSL certificate
                                                    verification
      ssl-verification-on                           Reenables SSL certificate
                                                    verification
    
                                     Miscellaneous
    
      e[xit]                                        Alias for qui[t]
      hel[p] [COMMAND]                              Displays this help table, or
                                                    help on the specified command
      qui[t]                                        Quits htty
      un[do]                                        (Help for un[do] is not
                                                    available)
    
    http://0.0.0.0/> 

The `help` command takes an optional argument of the abbreviated or full name of a command.