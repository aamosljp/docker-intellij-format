# docker-intellij-format

Docker container to run the IntelliJ formatter on your groovy files.

## Usage

```
$ docker run --rm intellij-format -h
IntelliJ IDEA 2023.3.2, build IC-233.13135.103 Formatter
Usage: format [-h] [-r|-R] [-s|-settings settingsPath] path1 path2...
  -h|-help         Show a help message and exit.
  -s|-settings     A path to Intellij IDEA code style settings .xml file. This setting will be
                   be used as a primary one regardless to the surrounding project settings
  -r|-R            Scan directories recursively.
  -d|-dry          Perform a dry run: no file modifications, only exit status.
  -m|-mask         A comma-separated list of file masks.
  -charset         Force charset to use when reading and writing files.
  -allowDefaults   Use factory defaults when style is not defined for a given file. I.e. when -s
                   is not not set and file doesn't belong to any IDEA project. Otherwise file will
                   be ignored.
  path<n>        A path to a file or a directory.

```

### Formatting your files

Use the `--user` option to preserve your files ownership and the `--volume` option to mount your current directory in the container. 

- Format a single _HelloWorld.groovy_ groovy file:

```
$ docker run --rm --user $(id -u):$(id -g) --volume $(pwd):/data intellij-format HelloWorld.groovy
```

- Format all the groovy files in the current directory recursively:

```
$ docker run --rm --user $(id -u):$(id -g) --volume $(pwd):/data intellij-format -r -m *.groovy .
```

## Building the image

```
$ docker build -t intellij-format .
```

## Code style settings

By default, the IntelliJ formatter will use the code style settings configured in the file _groovy-code-style.xml_.

This file can be generated directly from IntelliJ by following this documentation: [Copying Code Style Settings](https://www.jetbrains.com/help/idea/copying-code-style-settings.html)

Since this code style settings file is copied during the build of the image, any modification to it must be followed by a re-build of the container to be applied. This mechanism allows for a versionning of the code style settings with the repository. 
