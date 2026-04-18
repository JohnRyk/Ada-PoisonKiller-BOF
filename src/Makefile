CC64 = x86_64-w64-mingw32-gcc
STRIP64 = x86_64-w64-mingw32-strip --strip-unneeded
CFLAGS = -I ../_include -w -Wno-incompatible-pointer-types -Os -DBOF -c


bof: clean
	@(mkdir ../_bin 2>/dev/null) && echo 'creating _bin directory' || echo '_bin directory exists'
	# 64-bit build
	@($(CC64) $(CFLAGS) loaddriver.c -o ../_bin/loaddriver.x64.o && $(STRIP64) ../_bin/loaddriver.x64.o && echo '[+] loaddriver x64' || echo '[!] loaddriver x64')
	@($(CC64) $(CFLAGS) unloaddriver.c -o ../_bin/unloaddriver.x64.o && $(STRIP64) ../_bin/unloaddriver.x64.o && echo '[+] unloaddriver x64' || echo '[!] unloaddriver x64')
	@($(CC64) $(CFLAGS) killprocess.c -o ../_bin/killprocess.x64.o && $(STRIP64) ../_bin/killprocess.x64.o && echo '[+] killprocess x64' || echo '[!] killprocess x64')
	@($(CC64) $(CFLAGS) kill_multi.c -o ../_bin/kill_multi.x64.o && $(STRIP64) ../_bin/kill_multi.x64.o && echo '[+] kill_multi x64' || echo '[!] kill_multi x64')
	@($(CC64) $(CFLAGS) delete.c -o ../_bin/delete.x64.o && $(STRIP64) ../_bin/delete.x64.o && echo '[+] delete x64' || echo '[!] delete x64')
clean:
	@(rm -rf ../_bin)



