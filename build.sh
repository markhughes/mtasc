#!/bin/bash
set -euo pipefail
echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # ocaml setup"
echo " ###################################################### "
echo ""

# get env 
eval $(opam env)

if [ -z "${GITHUB_ACTIONS:-}" ]; then
  # Not in GitHub Actions environment
  # Create and set the older OCaml switch
  opam switch create 4.12.0 || opam switch set 4.12.0
  
  # Set the environment to 4.12.0
  eval $(opam env)
fi

# camlp5 needs the perl modules IPC::System::Simple and String::ShellQuote, which opam
# can't install on cygwin, so drop the (pure perl) modules into cygwin perl directly
case "$(uname -s)" in
  CYGWIN*)
    opam install -y conf-perl
    PERL_SITELIB="$(perl -MConfig -e 'print $Config{installsitelib}')"
    mkdir -p "$PERL_SITELIB/IPC/System" "$PERL_SITELIB/String"
    curl -fsSL https://fastapi.metacpan.org/source/JKEENAN/IPC-System-Simple-1.30/lib/IPC/System/Simple.pm \
      > "$PERL_SITELIB/IPC/System/Simple.pm"
    curl -fsSL https://fastapi.metacpan.org/source/ROSCH/String-ShellQuote-1.04/ShellQuote.pm \
      > "$PERL_SITELIB/String/ShellQuote.pm"
    ;;
esac

opam install -y camlp5 extlib ocamlfind

# update environment as some systems don't always have the correct path set for those executables
eval $(opam env)

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # clean up previous build files"
echo " ###################################################### "
echo ""

# top level only: subdirectories include the submodules and opam's local switch (./_opam)
find . -maxdepth 1 -type f \( -name "*.cmi" -o -name "*.cmo" -o -name "*.p.ml" -o -name "*.cmx" -o -name "*.o" \) \
    -exec rm -f {} +

rm -f lexer.ml

echo "all clean!"

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # zlib build"
echo " ###################################################### "
echo ""

# use the same C compiler as OCaml so libz.a can be linked (matters for mingw on windows)
cd zlib
CC="$(ocamlfind ocamlopt -config-var c_compiler)" ./configure --static
make libz.a
cd ..

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # mtasc build"
echo " ###################################################### "
echo ""

# Build the project
ocaml ./build-helper.ml

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # copying installers"
echo " ###################################################### "
echo ""

cp install.bat bin
cp install.sh bin

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # completed!"
echo " ###################################################### "
echo ""
echo "contents in ./bin:"
ls -al ./bin

echo ""