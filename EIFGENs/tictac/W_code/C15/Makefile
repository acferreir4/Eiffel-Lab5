INCLUDE_PATH =  -I"$(ISE_LIBRARY)/library/encoding/implementation/include" -I"$(ISE_LIBRARY)/library/process/classic/unix/include" -I"$(ISE_LIBRARY)/library/vision2/spec/include" -I"$(ISE_LIBRARY)/library/vision2/implementation/gtk/Clib"  -pthread -I/usr/include/gtk-2.0 -I/usr/lib64/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng12
SHELL = /bin/sh
CC = gcc
CPP = g++
CFLAGS = -O0 -pipe -fPIC -D_GNU_SOURCE -m64  -DEIF_IEEE_BEHAVIOR -DWORKBENCH -I"/cs/local/packages/Eiffel16.05/studio/spec/linux-x86-64/include" -I. $(INCLUDE_PATH)
CPPFLAGS = -O0 -pipe -fPIC -D_GNU_SOURCE -m64  -DWORKBENCH -I"/cs/local/packages/Eiffel16.05/studio/spec/linux-x86-64/include" -I. $(INCLUDE_PATH)
LDFLAGS = -m elf_x86_64
CCLDFLAGS = -m64  
LDSHAREDFLAGS =  -m elf_x86_64 -shared -o
EIFLIB = "/cs/local/packages/Eiffel16.05/studio/spec/linux-x86-64/lib/libwkbench.a"
EIFTEMPLATES = /cs/local/packages/Eiffel16.05/studio/config/linux-x86-64/templates
LIBS = -lm
MAKE = make
AR = ar
LD = ld
MKDEP = \$(EIFFEL_SRC)/C/mkdep $(DPFLAGS) --
MV = /bin/mv
CP = /bin/cp
RANLIB = :
RM = /bin/rm -f
FILE_EXIST = 
RMDIR = 
X2C = "/cs/local/packages/Eiffel16.05/studio/spec/linux-x86-64/bin/x2c"
SHAREDLINK = ld
SHAREDLIBS = -lm
SHARED_SUFFIX = .so
COMMAND_MAKEFILE = 
START_TEST = if [ ! -f finished ] ; then 
END_TEST = ; fi 
CREATE_TEST = touch finished 
SYSTEM_IN_DYNAMIC_LIB = tictac.so 

.SUFFIXES:.cpp .o

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CPP) $(CPPFLAGS) -c $<

OBJECTS = big_file_C15_c.o 

OLDOBJECTS =  ev1422.o ev1422d.o ev1446.o ev1446d.o ev1420.o ev1420d.o ev1438.o \
	ev1438d.o ev1442.o ev1442d.o ev1434.o ev1434d.o ev1437.o ev1437d.o \
	ev1433.o ev1433d.o ev1436.o ev1436d.o ev1424.o ev1424d.o ev1423.o \
	ev1423d.o ev1443.o ev1443d.o ev1439.o ev1439d.o ev1425.o ev1425d.o \
	ev1432.o ev1432d.o ev1435.o ev1435d.o ev1421.o ev1421d.o ev1415.o \
	ev1415d.o ev1431.o ev1431d.o ev1444.o ev1444d.o ev1426.o ev1426d.o \
	ev1429.o ev1429d.o ev1430.o ev1430d.o ev1419.o ev1419d.o ev1418.o \
	ev1418d.o ev1417.o ev1417d.o ev1416.o ev1416d.o ev1428.o ev1428d.o \
	ev1440.o ev1440d.o ev1427.o ev1427d.o ev1414.o ev1414d.o ev1445.o \
	ev1445d.o ev1441.o ev1441d.o 

all: Cobj15.o

Cobj15.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj15.o $(OBJECTS)
	$(RM) $(OBJECTS)
	$(CREATE_TEST)

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core finished *.o

local_clobber:: local_clean
	$(RM) Makefile

