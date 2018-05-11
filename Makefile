PROG=	ldapclient
SRCS=	ldapclient.c aldap.c ber.c log.c
LDADD+=	-ltls -levent -lutil
DPADD+=	${LIBTLS} ${LIBEVENT} ${LIBUTIL}
NOMAN=	yes

.include <bsd.prog.mk>
