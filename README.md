ldap(1) - General Commands Manual

# NAME

**ldap** - Simple LDAP client.

# SYNOPSIS

**ldap**
*command*
\[**-LvWxZ**]
\[**-b**&nbsp;*basedn*]
\[**-c**&nbsp;*CAfile*]
\[**-D**&nbsp;*binddn*]
\[**-H**&nbsp;*host*]
\[**-l**&nbsp;*timelimit*]
\[**-s**&nbsp;*scope*]
\[**-w**&nbsp;*secret*]
\[**-z**&nbsp;*sizelimit*]
\[*arguments&nbsp;...*]

# DESCRIPTION

The
**ldap**
program is a simple LDAP client program.
It queries an LDAP server to perform a command and outputs the results
in the LDAP Data Interchange Format (LDIF).

The command is as follows:

**search** *options* *filter* \[*attribute ...*]

> Perform a directory search request.
> The optional
> *filter*
> argument specifies the LDAP filter for the directory search.
> The default is
> *(objectClass=\*)*
> and the format must comply to the
> "String Representation of Search Filters"
> as described in RFC 4515.
> If one or more
> *attribute*
> options are specified,
> **ldap**
> restricts the output to the specified attributes.

The options are as follows:

**-b** *basedn*

> Use the specified distinguished name (dn) as the starting point for
> directory search requests.

**-c** *CAfile*

> When TLS is enabled, load the CA bundle for certificate verification
> from the specified file.
> The default is
> */etc/ssl/cert.pem*.
> If the LDAP server uses a self-signed certificate,
> use a file that contains the server certificate in PEM format, e.g.
> */etc/ssl/ldapserver.example.com.crt*.

**-D** *binddn*

> Use the specified distinguished name to bind to the directory.

**-H** *host*

> The hostname of the LDAP server or an LDAP URL.
> The LDAP URL is described in RFC 4516 with the following format:

> \[*protocol*://]*host*\[:*port*]\[*/basedn*\[*&#63;attribute,...*]\[*&#63;scope*]\[*&#63;filter*]]

> The following protocols are supported:

> ldap

> > Connect with TCP in plain text.
> > This is the default.

> ldaps

> > Connect with TLS.
> > The default port is 636.

> ldap+tls

> > Connect with TCP and enable TLS using the StartTLS operation.
> > This is the same as the
> > **-Z**
> > option.

> ldapi

> > Connect to a UNIX-domain socket.
> > The host argument is required to be an URL-encoded path, for example
> > *ldapi://%2fvar%2frun%2fldapi*
> > for
> > */var/run/ldapi*.

> The default is
> *ldap://localhost:389/*.

**-L**

> Output the directory search result in a standards-compliant version of
> the LDAP Data Interchange Format (LDIF).
> This encodes attribute values that include non-printable or UTF-8
> characters in the Base64 format and wraps lines at a 79-character limit.
> If this option is not specified,
> **ldap**
> encodes
> "unsafe"
> characters and newlines in a visual format using
> vis(3)
> instead.

**-l** *timelimit*

> Request the server to abort the search request after
> *timelimit*
> seconds.
> The default value is
> *0*
> for no limit.

**-s** *scope*

> Specify the
> *scope*
> to be either
> **base**,
> **one**,
> or
> **sub**.
> The default is
> **sub**
> for subtree searches.

**-v**

> Product more verbose output.

**-W**

> Prompt for the bind secret with echo turned off.

**-w** *secret*

> Specify the bind secret on the command line.

**-x**

> Use simple authentication.
> This is the default as
> **ldap**
> does not support SASL authentication.

**-Z**

> Enable TLS using the StartTLS operation.

**-z** *sizelimit*

> Request the server to limit the search result to a maximum number of
> *sizelimit*
> entries.
> The default value is
> *0*
> for no limit.

# EXAMPLES

The following script can be used with the
*AuthorizedKeysCommand*
option of
sshd(8):

	#!/bin/sh
	ldap search -D cn=Reader,dc=example,dc=com -w mypass123 \
		-b ou=People,dc=example,dc=com \
		-H ldapserver -c /etc/ssl/ldapserver.crt -Z \
		"(&(objectClass=bsdAccount)(uid=$1))" sshPublicKey | \
		sed 's/sshPublicKey: //'
	exit 0

And the related configuration in
sshd\_config(5):

	Match Group ldapusers
		AuthorizedKeysCommand /etc/ssh/ldap-authorized_keys.sh
		AuthorizedKeysCommandUser _ldap

# FILES

*/etc/ssl/cert.pem*

> Default CA file.

# SEE ALSO

sshd\_config(5),
ldapd(8),
sshd(8)

# STANDARDS

G. Good,
*The LDAP Data Interchange Format (LDIF) - Technical Specification*,
RFC 2849,
June 2000.

M. Smith, Ed.,
T. Howes,
*Lightweight Directory Access Protocol (LDAP): String Representation of Search Filters*,
RFC 4515,
June 2006.

M. Smith, Ed.,
T. Howes,
*Lightweight Directory Access Protocol (LDAP): Uniform Resource Locator*,
RFC 4516,
June 2006.

# AUTHORS

The
**ldap**
program was written by
Reyk Floeter &lt;[reyk@openbsd.org](mailto:reyk@openbsd.org)&gt;.

# CAVEATS

The
**ldap**
tool does not support SASL authentication;
authentication should be performed using simple authentication over a
TLS connection.

OpenBSD 6.3 - May 17, 2018
