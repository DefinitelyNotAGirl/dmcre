# DMCRE: Dynamic Machine-Code Runtime Engine

- JIT compiles code
- provides module functionality
- mainly intended as a dev tool and a replacement for nodejs which just kicks and screams every chance it gets in that role

### ***windows support is broken at this time on account of clang not wanting to properly generate code under windows for whatever reason and me having ran out of fucks to give and therefore not spending days on end fixing it***

# installation
## MacOS
- install xcode if you dont already have it installed
- `git clone https://github.com/definitelynotagirl/dmcre`
- `cd dmcre`
- `./install-macOS.sh`
- add `$HOME/.dmcre/bin/` to PATH

## Linux
*note: this is untested, should work tho*
- `git clone https://github.com/definitelynotagirl/dmcre`
- `cd dmcre`
- `./install-linux.sh`
- add `$HOME/.dmcre/bin/` to PATH

## Windows
- install visual studio if you dont already have it installed
- `git clone https://github.com/definitelynotagirl/dmcre`
- `cd dmcre`
- `install-windows.bat`
- add `%USERPROFILE%/.dmcre/bin/` to PATH
