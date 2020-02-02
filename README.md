# Smart XML Analyzer

## Dependencies

For this application to run it is needed to have installed Perl interpreter (included by default in most unix distributions) and Mojo library
Just run `cpan Mojolicious` in your terminal and you will be ready

## Compiling

As this is done in Perl, no compilation is needed

## Running
To run this application, you need to run it in your terminal with the following format

```sh
$ perl main.pl <originalFile> <newFile>
```

### Examples

The original will always be sample-0 and the others are modified ones
Here are the different testing runs with their corresponding outputs

```sh
$ perl main.pl examples/sample-0-origin.html examples/sample-1-evil-gemini.html
> html > body > div > div > div > div > div > div > a
```

```sh
$ perl main.pl examples/sample-0-origin.html examples/sample-2-container-and-clone.html
> html > body > div > div > div > div > div > div > div > a
```

```sh
$ perl main.pl examples/sample-0-origin.html examples/sample-3-the-escape.html
> html > body > div > div > div > div > div > div > a
```

```sh
$ perl main.pl examples/sample-0-origin.html examples/sample-4-the-mash.html
> html > body > div > div > div > div > div > div > a
```