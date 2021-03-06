RM=rm -f
CFLAGS=-Wall -Ofast -I/opt/local/include
# CFLAGS=-Wall -g -I/opt/local/include
# DEFS=
LDFLAGS=-L/opt/local/lib

# Uncomment under Win32 (CYGWIN/MinGW):
# EXE=.exe

NRF905_DEMOD=nrf905_demod$(EXE)
SV6X0_DEMOD=sv6x0_demod$(EXE)
OGNTP_DEMOD=ogntp_demod$(EXE)
FLARM_DECODE=flarm_decode$(EXE)
OGNTP_DECODE=ogntp_decode$(EXE)
P3I_DECODE=p3i_decode$(EXE)

all: $(NRF905_DEMOD) $(SV6X0_DEMOD) $(OGNTP_DEMOD) $(FLARM_DECODE) $(OGNTP_DECODE) $(P3I_DECODE)
	strip $(NRF905_DEMOD) $(SV6X0_DEMOD) $(OGNTP_DEMOD) $(FLARM_DECODE) $(OGNTP_DECODE) $(P3I_DECODE)

$(NRF905_DEMOD): nrf905_demod.o lib_crc.o
	$(CC) ${LDFLAGS} -o $(NRF905_DEMOD) nrf905_demod.o lib_crc.o -lm

$(SV6X0_DEMOD): sv6x0_demod.o lib_crc.o
	$(CC) ${LDFLAGS} -o $(SV6X0_DEMOD) sv6x0_demod.o lib_crc.o -lm

$(OGNTP_DEMOD): ogntp_demod.o
	$(CC) ${LDFLAGS} -o $(OGNTP_DEMOD) ogntp_demod.o -lm

$(FLARM_DECODE): flarm_decode.o
	$(CC) ${LDFLAGS} -o $(FLARM_DECODE) flarm_decode.o -lm

$(OGNTP_DECODE): ogntp_decode.o
	$(CC) ${LDFLAGS} -o $(OGNTP_DECODE) ogntp_decode.o -lm

$(P3I_DECODE): p3i_decode.o
	$(CC) ${LDFLAGS} -o $(P3I_DECODE) p3i_decode.o -lm

lib_crc.o: lib_crc.h

flarm_decode.o: flarm_codec.h

sv6x0_demod.o: Protocol_P3I.h

p3i_decode.o: Protocol_P3I.h

.c.o:
	$(CC) ${CFLAGS} ${DEFS} -c $*.c

clean:
	$(RM) $(NRF905_DEMOD) $(SV6X0_DEMOD) $(OGNTP_DEMOD) $(FLARM_DECODE) $(OGNTP_DECODE) $(P3I_DECODE) *.o core
