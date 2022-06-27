# LocalWeb

Start up a local web server (http or https) and browse for files in a specific folder.  

## Usage

Just clone this repository or download zip to the local directory, build and run this project:

```
$ swift run
```

Open browser and connect to `http://localhost:7920` to browse files. Also you can edit the `.env` file to configure root folder with variable `rootFolder`. 

To provide HTTPS protocol, just add `certFile` and `certKey` variables in `.env` file to specify the certificate file and private key file. You could get the certificate for local development environment with the [mkcert](https://github.com/FiloSottile/mkcert) tool.

## CLI tool `localWeb`

With `localWeb` CLI tool, you can run this command and pass options to start up LocalWeb:

```
$ localWeb -h
USAGE: hummingbird-arguments [--host <host>] [--port <port>] [--root <root>] [--cert-file <cert-file>] [--cert-key <cert-key>]

OPTIONS:
  --host <host>           (default: 127.0.0.1)
  --port <port>           (default: 7920)
  --root <root>           (default: /tmp)
  --cert-file <cert-file>
  --cert-key <cert-key>
  -h, --help              Show help information.
```
