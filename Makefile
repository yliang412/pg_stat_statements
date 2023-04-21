# pgext_stat_statements/Makefile

MODULE_big = pgext_pg_stat_statements
OBJS = \
	$(WIN32RES) \
	pgext_pg_stat_statements.o

EXTENSION = pgext_pg_stat_statements
DATA = pgext_pg_stat_statements--1.4.sql \
	pgext_pg_stat_statements--1.9--1.10.sql pgext_pg_stat_statements--1.8--1.9.sql \
	pgext_pg_stat_statements--1.7--1.8.sql pgext_pg_stat_statements--1.6--1.7.sql \
	pgext_pg_stat_statements--1.5--1.6.sql pgext_pg_stat_statements--1.4--1.5.sql \
	pgext_pg_stat_statements--1.3--1.4.sql pgext_pg_stat_statements--1.2--1.3.sql \
	pgext_pg_stat_statements--1.1--1.2.sql pgext_pg_stat_statements--1.0--1.1.sql
PGFILEDESC = "pgext_pg_stat_statements - execution statistics of SQL statements"

LDFLAGS_SL += $(filter -lm, $(LIBS))

# TODO(yuchen): check if the regress opt need to change
REGRESS_OPTS = --temp-config ./pgext_pg_stat_statements.conf
REGRESS = pg_stat_statements oldextversions
# Disabled because these tests require "shared_preload_libraries=pg_stat_statements",
# which typical installcheck users do not have (e.g. buildfarm clients).
NO_INSTALLCHECK = 1

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/pgext_pg_stat_statements
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
