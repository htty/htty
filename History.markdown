Version history for the _htty_ project
======================================

<a name="v1.5.0"></a>v1.5.0, Tue 4/01/2014
-------------------------------------------

* Added support for Ruby v1.9.3, v2.0, and v2.1 \[with help from [gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")\]
* Added the `body-edit` command for using `$EDITOR` to manipulate the request body [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Added support for following relative URIs in _Location_ response headers [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Added support for automatically URL-encoding reserved characters such as _?_ [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Added support for automatically synchronizing userinfo and the _Authorization_ request header [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Improved support for scripting via _stdin_ [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Added support for case-insensitive editing of request headers [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Fixed a bug that mangled the prompt upon backspace [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Fixed bugs in the `query-*` commands [[gabrielelana](http://github.com/gabrielelana "gabrielelana at GitHub")]
* Updated and refined dependencies

<a name="v1.4.1"></a>v1.4.1, Wed 9/26/2012
-------------------------------------------

* Fixed a bug in line wrapping of long command prompts

<a name="v1.4.0"></a>v1.4.0, Sat 3/10/2012
-------------------------------------------

* Added `http-patch` and `patch` commands to support HTTP PATCH
* Refined dependencies

<a name="v1.3.4"></a>v1.3.4, Mon 10/17/2011
-------------------------------------------

* Added support for Ctrl-D to exit and to terminate `body-set` command input \[with help from [bofrede](http://github.com/bofrede "bofrede at GitHub")\]
* Added `--version` and `--help` command-line arguments

<a name="v1.3.3"></a>v1.3.3, Sat 3/05/2011
-------------------------------------------

* Fixed a bug in the `query-add` and `query-set` commands

<a name="v1.3.2"></a>v1.3.2, Fri 3/04/2011
-------------------------------------------

* Fixed configuration issues related to [rubygems-test](http://rubygems.org/gems/rubygems-test) gem support

<a name="v1.3.1"></a>v1.3.1, Fri 2/25/2011
-------------------------------------------

* Fixed a bug in the `body-request-open` and `body-response-open` commands

<a name="v1.3.0"></a>v1.3.0, Fri 2/25/2011
-------------------------------------------

* Added the `body-request-open` and `body-response-open` commands for viewing body content in an external program \[with help from [rbxbx](http://github.com/rbxbx "rbxbx at GitHub")\]
* Added validation of the URL scheme
* Added support for the [rubygems-test](http://rubygems.org/gems/rubygems-test) gem for compatibility testing in the field
* Refined dependencies

<a name="v1.2.1"></a>v1.2.1, Wed 12/01/2010
-------------------------------------------

* Made Ruby v1.8.7 or later a requirement for gem installation
* Upgraded dependencies

<a name="v1.2.0"></a>v1.2.0, Wed 12/01/2010
-------------------------------------------

* Added support for Tab-key completion of user input [[carsonmcdonald](http://github.com/carsonmcdonald "carsonmcdonald at GitHub")]
* Enhanced the `query-unset` command to accept an optional _value_ argument [[nextmat](http://github.com/nextmat "nextmat at GitHub")]

<a name="v1.1.6"></a>v1.1.6, Mon 11/22/2010
-------------------------------------------

* Added the `query-add` and `query-remove` commands [[nextmat](http://github.com/nextmat "nextmat at GitHub")]
* Added context-sensitive help in connection with server certificate verification
* Upgraded various dependencies

<a name="v1.1.5"></a>v1.1.5, Wed 10/20/2010
-------------------------------------------

* Added the `ssl-verification*` commands for controlling the verification of server certificates [[dtjm](http://github.com/dtjm "dtjm at GitHub")]
* Fixed a bug in the `query-set` command [[nextmat](http://github.com/nextmat "nextmat at GitHub")]
* Fixed a Ruby < v1.9 compatibility problem

<a name="v1.1.4"></a>v1.1.4, Sat 10/16/2010
-------------------------------------------

* Enhanced the `query-set` command [[nextmat](http://github.com/nextmat "nextmat at GitHub")] to:
  - Accept an arbitrary number of arguments
  - Support valueless keys
  - Support duplicate keys
  - Support keys with brackets in their names, à la Rails

<a name="v1.1.3"></a>v1.1.3, Tue 10/12/2010
-------------------------------------------

* Fixed a bug in the arrow keys and Emacs key bindings support within the `body-set` command [ephox-rob/[rojotek](http://github.com/rojotek "rojotek at GitHub")]
* Fixed a bug involving empty response bodies such as are received with _304 Not Modified_

<a name="v1.1.2"></a>v1.1.2, Wed 9/29/2010
------------------------------------------

* Stopped recording blank and repeated entries in the command history [[jgorset](http://github.com/jgorset "jgorset at GitHub")]
* Fixed a bug in the help index

<a name="v1.1.1"></a>v1.1.1, Tue 9/28/2010
------------------------------------------

* Classified RubyGems for building documentation as development-only dependencies

<a name="v1.1.0"></a>v1.1.0, Tue 9/28/2010
------------------------------------------

* Added HTTP Secure support
* Added HTTP Basic Authentication support
* Added support for arrow keys and Emacs key bindings [[rbxbx](http://github.com/rbxbx "rbxbx at GitHub")]
* Added support for Ctrl-D for terminating input [[bofrede](http://github.com/bofrede "bofrede at GitHub")]
* Enhanced the _userinfo-set_ command to:
  - Permit separate entry of username and (optional) password
  - Permit colon-separated “username:password” entry
  - Automatically URL-escape _@_ symbols to avoid invalid URLs
* Fixed various bugs
* Corrected and expanded built-in help content

<a name="v1.0.0"></a>v1.0.0, Mon 9/06/2010
------------------------------------------

(First release)
