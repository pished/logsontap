---
title: "Brief Go Introduction"
date: 2020-03-10T21:34:26-04:00
lastmod: 2020-03-10T21:34:26-04:00
draft: false
notebooks: ["go"]
series: []
tags: ["package management", "go modules"]
author: ""
toc: true
---

*Written for Go v1.14*

Golang, or Go, is an open-sourced language created by Ken Thompson, Rob Pike, and Robert Griesemer at Google. Originally, the compiler was written in `C` but since then it has been [rewritten in Go](https://github.com/golang/go). The original goal of Go was to replace traditional low-level languages like `C` and `C++` and build upon them by offering improved simplicity.

<!--more-->

Notable Go features:  

- Is a compiled, statically typed language
- Focused around concurrency through use of GoRoutines
- Key distinction from C/C++ with built-in garbage collection and memory safety
- Strings default as UTF-8 encoded [^1]
- Borrows much syntax of modern interpreted languages

Installing Go will give the entire *language specifications*, *standard library* (over 100 for common use), *runtime environment*, and the *compiler* to the user in `/usr/local/go` for UNIX systems or `c:/go` for Windows. 

Like other languages, working in Go needs some sort of organization. The **repository** (used to be referred to as the workspace pre-module era) in Go is any directory on your system that you wish to use to hold the source code of your project or application. Since the inception of Go Modules in v1.11 the `GOPATH` is no longer needed when setting up a repository and since v1.13 they have become the default for all development. Creating a module path is simple and usually done in the base of the directory with the `go mod init` command. You can check the version you have installed with `go version`. If you alter your default installation directory for some reason then you should also change the `GOROOT` environment variable.

Go can be further split into **packages** which consist of all the source files in the same directory which get compiled together. Similar to other languages, all of the functions, types, variables, and constants that you expose in any given package can be available to another - given the proper syntax. Many individual packages can make up a repository that are usually defined by a single module located at the root level. The `go.mod` file describes the *module path* which is just the import path prefix that all packages within the module have. It also contains all the packages for the module as well as any in subdirectories of the module, up until another `go.mod` is found.

Each file written in Go needs to have exactly the libraries it uses declared at the top after it's package name. Hence, the *import path* is the string used to tell Go which package the code is looking to make use of. The import path itself is just the *module path* joined with its subdirectory name (if any). Standard library packages don't use module path prefixes.

## Creating a Repository

Create a directory anywhere you like named `demo`. In the newly created directory, execute `go mod init example.com/user/demo` (you could write `github.com/user/...` if you were going to check it in). As stated earlier, the first line in a `.go` file must be its package name, and if you want the program to be executable it needs to have a `package main` somewhere in it. Coincidentally, an executable program also needs a function called `main()` to be the entry point. That said, here is what a hello world program looks like.

```go
package main

import "fmt"

func main() {
	fmt.Println("Hello, world.")
}
```

We will call this file `demo.go` and just place it in the root directory of the repository, same place as the `go.mod` file.


[^1]: Basics of Bits, Bytes, and Encoding
