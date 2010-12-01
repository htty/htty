Version history for the _htty_ project
======================================

v1.2.0, Wed 12/01/2010
---------------------

* Added support for Tab-key completion of user input [[carsonmcdonald](http://github.com/carsonmcdonald "carsonmcdonald at GitHub")]
* Enhanced the `query-unset` command to accept an optional _value_ argument [[mattsa](http://github.com/mattsa "mattsa at GitHub")]

v1.1.6, Mon 11/22/2010
---------------------

* Added the `query-add` and `query-remove` commands [[mattsa](http://github.com/mattsa "mattsa at GitHub")]:
* Added context-sensitive help in connection with server certificate verification
* Upgraded various dependencies

v1.1.5, Wed 10/20/2010
---------------------

* Added the `ssl-verification*` commands for controlling the verification of server certificates [[dtjm](http://github.com/dtjm "dtjm at GitHub")]
* Fixed a bug in the `query-set` command [[mattsa](http://github.com/mattsa "mattsa at GitHub")]
* Fixed a Ruby < v1.9 compatibility problem

v1.1.4, Sat 10/16/2010
---------------------

* Enhanced the `query-set` command [[mattsa](http://github.com/mattsa "mattsa at GitHub")] to:
  - Accept an arbitrary number of arguments
  - Support valueless keys
  - Support duplicate keys
  - Support keys with brackets in their names, à la Rails

v1.1.3, Tue 10/12/2010
---------------------

* Fixed a bug in the arrow keys and Emacs key bindings support within the `body-set` command [ephox-rob/[rojotek](http://github.com/rojotek "rojotek at GitHub")]
* Fixed a bug involving empty response bodies such as are received with _304 Not Modified_

v1.1.2, Wed 9/29/2010
---------------------

* Stopped recording blank and repeated entries in the command history [[jgorset](http://github.com/jgorset "jgorset at GitHub")]
* Fixed a bug in the help index

v1.1.1, Tue 9/28/2010
---------------------

* Classified RubyGems for building documentation as development-only dependencies

v1.1.0, Tue 9/28/2010
---------------------

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

v1.0.0, Mon 9/06/2010
---------------------

(First release)
