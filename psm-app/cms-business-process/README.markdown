# cms-business-process

The `cms-business-process` subproject contains the interfaces between the rest
of the PSM and the workflow engine, [jBPM](https://en.wikipedia.org/wiki/JBPM),
as well as the interfaces between the PSM and the rules engine,
[Drools](https://en.wikipedia.org/wiki/Drools).

In support of that, the business process and rules we use live in
`src/main/resources/`.

## Business Process

We have a single business process, `ApplicationProcess.bpmn`, which determines
what happens after a user clicks "Submit Application". The PSM hands the
application off to jBPM, and jBPM takes it through the process,
calling back into the work item handlers defined in
`src/main/java/gov/medicaid/process/application`.

### jBPM Editor

To edit the application process, you'll most likely want to use the jBPM editor,
which is distributed as a plugin to Eclipse.

1. Download
  [jbpm-5.4.0.Final-installer-full.zip](https://sourceforge.net/projects/jbpm/files/jBPM%205/jbpm-5.4.0.Final/jbpm-5.4.0.Final-installer-full.zip/download)
  and extract it.
1. In the extracted jBPM installer, extract
  `lib/org.drools.updatesite-5.5.0.Final-assembly.zip`.
1. Install and start Eclipse. I was able to use [the version shipped in Ubuntu
  16.04](https://packages.ubuntu.com/xenial/eclipse), which meant a simple
  `sudo apt install eclipse`.
1. The Drools GUI depends on the GEF libraries. Add the GEF repository to
  Eclipse:
    1. Open the install dialog box: `Help` > `Install New Software...`.
    1. Open the add repository dialog box: `Add...`.
    1. Name the new repository `GEF`, and set the location to
      `http://download.eclipse.org/tools/gef/updates/releases/`.
1. Add the Drools repository from the locally extracted Drools zip file:
    1. Open the install dialog box: `Help` > `Install New Software...`.
    1. Open the add repository dialog box: `Add...`.
    1. Name the new repository `Drools 5.5`, click `Local`, browse to the
      directory you extracted
      `lib/org.drools.updatesite-5.5.0.Final-assembly.zip` into, and click `OK`.
1. Make sure the newly-added Drools repository is selected.
1. Select the `Drools and jBPM` package (or click `Select All`), and click
  `Finish`.

Once the GUI is set up, you can make a new Drools project and import the files
in `cms-business-process/src/main/resources/`. There may be errors
around missing imports, since it doesn't have access to the associated Java
code.

## Rules

We have two primary rules files:

- `cms.screening.drl`, which contains rules run during the admin review process.
- `cms.validation.drl`, which contains rules run during the provider application
  process.

Additionally, `cms.validation.dslr` currently contains a handful of provider
application validation rules that are written in the domain-specific language
defined in `cms.dsl`.
