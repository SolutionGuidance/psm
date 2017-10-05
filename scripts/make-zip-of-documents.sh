#!/bin/bash
set -ex

# Bundle user & developer docs into a zipped archive; issue # 458
# For this to work you'll need several Python & Debian packages installed
# See docs/userhelp/README.mdwn

mkdir documentation-bundle

# Use Pandoc to turn various Markdown documents into PDFs

pandoc -V colorlinks -t latex -o documentation-bundle/2_readme.pdf ../README.md
pandoc -V colorlinks -t latex -o documentation-bundle/4_install-instructions.pdf \
       ../INSTALL.md
pandoc -V colorlinks -t latex -o \
       documentation-bundle/9_developer-contribution-instructions.pdf \
       ../CONTRIBUTING.md
pandoc -V colorlinks -t latex -o documentation-bundle/6_architecture-design.pdf \
       ../docs/DESIGN.md
pandoc -V colorlinks -t latex -o documentation-bundle/5_dependencies-list.pdf \
       ../docs/DEPENDENCIES.md
pandoc  -V colorlinks -t latex -o documentation-bundle/8_testing-instructions.pdf \
       ../docs/TESTING.md
pandoc -V colorlinks -t latex -o documentation-bundle/7_leie_API.pdf \
       ../etl/leie/README.mdwn

# Use Pandoc to turn index page into a PDF

pandoc -V colorlinks -t latex -o documentation-bundle/1_table_of_contents.pdf \
       1_TOC.md

# Use Sphinx and LaTeX to turn user manual into a PDF

cd ../docs/userhelp/
make clean
make latexpdf
mv build/latex/ProviderScreeningModuleusermanual.pdf \
   ../../scripts/documentation-bundle/3_usermanual.pdf

# Build API docs

cd ../../psm-app
./gradlew cms-web:apiDocs
cp -r cms-web/build/reports/api-docs ../scripts/documentation-bundle/

# Move PDFs, API doc directory, logo, and HTML index file to ZIP file
# Syntax: zip options archive inpath inpath

cd ../scripts/documentation-bundle/
zip -mr documentation-bundle.zip ./*.pdf \
    api-docs

# Resulting file: documentation-bundle/documentation-bundle.zip

echo -e "Created archive file: documentation-bundle/documentation-bundle.zip\n"
