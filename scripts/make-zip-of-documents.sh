#!/bin/bash
set -ex

# Bundle user & developer docs into a zipped archive; issue # 458
# Run this from the `scripts` directory.
# For this to work you'll need a few Debian packages installed.
# See psm-app/userhelp/README.mdwn

DOCBUNDLEDIR=$(mktemp -d /tmp/doc-bundle-XXXXX)

# Remove the SVG from the README

sed 's/Current\sbuild\sstatus.*master.*//' ../README.md > $DOCBUNDLEDIR/README.md

# Use Pandoc to turn various Markdown documents into PDFs

pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/3_readme.pdf $DOCBUNDLEDIR/README.md
pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/4_architecture-design.pdf \
       ../docs/DESIGN.md
pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/6_interface_control_document.pdf \
       ../docs/ICD.md
pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/11_install-instructions.pdf \
       ../INSTALL.md
pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/12_dependencies-list.pdf \
       ../docs/DEPENDENCIES.md
pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/13_leie_README.pdf \
       ../etl/leie/README.mdwn
pandoc -V colorlinks -t latex -o $DOCBUNDLEDIR/14_leie_API.pdf \
       ../etl/leie/leie/api.mdwn
pandoc  -V colorlinks -t latex -o $DOCBUNDLEDIR/15_testing-instructions.pdf \
       ../docs/TESTING.md
pandoc -V colorlinks -t latex -o \
       $DOCBUNDLEDIR/16_developer-contribution-instructions.pdf \
       ../CONTRIBUTING.md

# Now that README has been turned into PDF, delete it

rm $DOCBUNDLEDIR/README.md

# Add index page, logo and stylesheet to doc bundle

cp make-zip-doc-support/1_table_of_contents.html \
   ../psm-app/cms-web/WebContent/i/psm-logo-small.png \
   make-zip-doc-support/style.css \
   $DOCBUNDLEDIR

# Add architecture diagrams to doc bundle

cp make-zip-doc-support/5_architecture-for-stakeholders-diagram.pdf \
   make-zip-doc-support/7_enrollment-process-diagram.png \
   make-zip-doc-support/8_screening-process-diagram.png \
   make-zip-doc-support/9_schema-compact-diagram.png \
   make-zip-doc-support/10_schema-hierarchical-diagram.png \
   $DOCBUNDLEDIR

# Use Gradle, Sphinx and LaTeX to turn user manual into a PDF

cd ../psm-app/
./gradlew userhelp:{clean,pdf}
mv userhelp/build/latex/ProviderScreeningModuleusermanual.pdf \
   $DOCBUNDLEDIR/2_usermanual.pdf

# Build API docs

./gradlew cms-web:apiDocs
cp -r cms-web/build/reports/api-docs $DOCBUNDLEDIR/

# Move PDFs, API doc directory, logo, and HTML index file to ZIP file
# Syntax: zip options archive inpath inpath

cd $DOCBUNDLEDIR
zip -mr documentation-bundle.zip ./*.pdf \
    ./*.png \
    ./*.html \
    ./*.css \
    api-docs

# Resulting file: $DOCBUNDLEDIR/documentation-bundle.zip

echo "Created archive file: $DOCBUNDLEDIR/documentation-bundle.zip"
