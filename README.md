ldapclient
==========

This is a simple LDAP search client.

Example
-------

The following command script can be used with OpenSSH's
`AuthorizedKeysCommand`:

```
#!/bin/sh
ldapclient -D cn=Reader,dc=example,dc=com -x -w mypass123 \
	-b ou=People,dc=example,dc=com \
	-h ldapserver -c /etc/ssl/ldapserver.crt -Z \
	"(&(objectClass=bsdAccount)(uid=$1))" sshPublicKey | \
	sed 's/sshPublicKey: //'
exit 0
```

TODO
----

- more cleanup
- ldapclient(1) man page
- integrate into OpenBSD ldapd's ldapctl(8)?

Author
------

Reyk Floeter (reyk@openbsd.org)

See [`LICENSE.md`](https://github.com/reyk/ldapclient/blob/master/LICENSE.md)
for information about copyright and licensing.
