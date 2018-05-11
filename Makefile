PROG=		ldapclient
SRCS=		ldapclient.c aldap.c ber.c log.c
LDADD+=		-ltls -levent -lutil
DPADD+=		${LIBTLS} ${LIBEVENT} ${LIBUTIL}
NOMAN=		yes

CFLAGS+=	-Wall
CFLAGS+=	-Wstrict-prototypes -Wmissing-prototypes
CFLAGS+=	-Wmissing-declarations
CFLAGS+=	-Wshadow -Wpointer-arith
CFLAGS+=	-Wsign-compare -Wcast-qual


.include <bsd.prog.mk>
