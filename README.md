ldapclient(1) - General Commands Manual

# NAME

**ldapclient** - Simple LDAP search client.

# SYNOPSIS

**ldapclient**
\[**-LvWxZ**]
\[**-b**&nbsp;*basedn*]
\[**-c**&nbsp;*CAfile*]
\[**-b**&nbsp;*binddn*]
\[**-D**&nbsp;*binddn*]
\[**-h**&nbsp;*host*]
\[**-p**&nbsp;*port*]
\[**-s**&nbsp;*scope*]
\[**-w**&nbsp;*secret*]
*filter*
\[*attribute&nbsp;...*]

# DESCRIPTION

The
**ldapclient**
program is a simple LDAP client program.
It queries an LDAP server to perform a directory search and outputs
the results in the LDAP Data Interchange Format (LDIF).

The optional
*filter*
argument specifies the LDAP filter for the directory search.
The default is
*(objectClass=\*)*
and the format must comply to the
"String Representation of Search Filters"
as described in RFC 4515.
If one or more
*attribute*
options are specified,
**ldapclient**
restricts the output to the specified attributes.

The options are as follows:

**-b** *basedn*

> Use the specified distinguished name (dn) as the starting point for
> the directory search.

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

**-h** *host*

> The hostname of the LDAP server.

**-L**

> Output the directory search result in a standards-compliant version of
> the LDAP Data Interchange Format (LDIF).
> This encodes attribute values that include non-printable or UTF-8
> characters in the Base64 format and wraps lines at a 79-character limit.
> If this option is not specified,
> **ldapclient**
> encodes
> "unsafe"
> characters and newlines in a visual format using
> vis(3)
> instead.

**-p** *port*

> The port of the LDAP server.
> The default is
> *389*.

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
> **ldapclient**
> does not support SASL authentication.

**-Z**

> Enable TLS using the StartTLS operation.

# EXAMPLES

The following script can be used with the
*AuthorizedKeysCommand*
option of
sshd(8):

	#!/bin/sh
	ldapclient -D cn=Reader,dc=example,dc=com -w mypass123 \
		-b ou=People,dc=example,dc=com \
		-h ldapserver -c /etc/ssl/ldapserver.crt -Z \
		"(&(objectClass=bsdAccount)(uid=$1))" sshPublicKey | \
		sed 's/sshPublicKey: //'
	exit 0

And the related configuration in
sshd\_config(5):

	Match Group ldapusers
		AuthorizedKeysCommand /etc/ssh/ldap-authorized_keys.sh
		AuthorizedKeysCommandUser _ldapclient

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

# AUTHORS

The
**ldapclient**
program was written by
Reyk Floeter &lt;[reyk@openbsd.org](mailto:reyk@openbsd.org)&gt;.

# CAVEATS

The
**ldapclient**
tool does not support SASL authentication;
authentication should be performed using simple authentication over a
TLS connection.

LDAP commonly supports two methods of establishing TLS:
TLS over LDAP using StartTLS (port 389), and LDAPS (port 636).
The LDAPS method is currently not supported.

OpenBSD 6.3 - May 15, 2018
