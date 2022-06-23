# LocalWeb

Start up local web server and browse for files in a specific folder.  

## Usage

Just clone this repository or download zip to the local directory, build and run this project:

```
$ swift run
```

Open browser and connect to `http://localhost:7920` to browse files. Also you can edit the `.env` file to configure root folder with variable `rootFolder`.  
## CLI tool `localWeb`

With `localWeb` CLI tool, you can run this command and pass options to start up LocalWeb:

```
$ localWeb -h
USAGE: hummingbird-arguments [--host <host>] [--port <port>] [--root <root>]

OPTIONS:
  --host <host>           (default: 127.0.0.1)
  --port <port>           (default: 7920)
  --root <root>           (default: /tmp)
  -h, --help              Show help information.
```
