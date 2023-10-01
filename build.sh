echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # ocaml setup"
echo " ###################################################### "
echo ""

# get env 
eval $(opam env)

# Create and set the older OCaml switch
opam switch create 4.12.0 || opam switch set 4.12.0

# Set the environment to 4.12.0
eval $(opam env)

# Install camlp4 for the older OCaml version
opam install camlp5
opam install extlib
opam install ocamlfind

# update environment as some systems don't always have the correct path set for those executables
eval $(opam env)

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # clean up previous build files"
echo " ###################################################### "
echo ""

find . -type f \( -name "*.cmi" -o -name "*.cmo" -o -name "*.p.ml" -o -name "*.cmx" -o -name "*.o" \) \
    ! -path "./zlib/*" ! -path "./ocaml/*" -exec rm -f {} +

rm lexer.ml

echo ""
echo ""
echo ""
echo " ###################################################### "
echo " # zlib build"
echo " ###################################################### "
echo ""

cd zlib 
./configure 
make
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
echo " # completed!"
echo " ###################################################### "
echo ""
echo "contents in ./bin:"
ls -al ./bin

echo ""