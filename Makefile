SIGNZONE = dnssec-signzone -K keys/ -d dssets/ -S -3 -
SIGNZONE += -N unixtime
SIGNZONE_FLAGS = 

# SIGNZONE = ldns-signzone -n
# SIGNZONE_FLAGS =

RELOAD_ZONES = nsd-control reload

.PHONY: all clean check update force-update
all:

all: example.org.signed
example.org.signed: src/example.org $(wildcard keys/Kexample.org*)
	$(SIGNZONE) $(SIGNZONE_FLAGS) -f $@ -o $(<F) $<

update: all
	$(RELOAD_ZONES)
	echo 

force-update: clean update

clean:
	$(RM) example.org.signed

