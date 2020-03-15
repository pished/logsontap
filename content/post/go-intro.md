---
title: "Brief Go Intro"
date: 2020-03-10T21:34:26-04:00
lastmod: 2020-03-10T21:34:26-04:00
draft: false
notebooks: ["go"]
series: []
tags: []
author: ""
toc: true
---

## A Brief Dip into Go

[Go | Golang ] is an open-sourced language created by Ken Thompson, Rob Pike, and Robert Griesemer at Google. Originally, the compiler was written in `C` but since then it has been [rewritten in Go](https://github.com/golang/go). The original goal of Go was to replace traditional low-level languages like `C` and `C++` and build upon them by offering improved simplicity.

<!--more-->

Notable Go features:  

- Is a compiled, statically typed language
- Focused around concurrency through use of GoRoutines
- Key distinction from C/C++ with built-in garbage collection and memory safety
- Strings default as UTF-8 encoded [^1]
- Borrows much syntax of modern interpreted languages

Installing Go will give the entire *language specifications*, *standard library*, *runtime environment*, and the *compiler* to the user in `/usr/local/go` for UNIX systems or `c:/go` for Windows. 

Since the inception of Go Modules in v1.11 the GOPATH is no longer needed when setting up a workspace and since v1.13 they have become the default for all development. Creating a module path is simple and usually done in the base of the directory with the `go mod init` command.

[^1]: Basics of Bits, Bytes, and Encoding
