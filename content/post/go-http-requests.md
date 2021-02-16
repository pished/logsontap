---
title: "Executing HTTP Method Requests in Go"
date: 2021-02-14T17:01:02-04:00
lastmod: 2021-02-14T17:01:02-04:00
draft: false
notebooks: [go]
series: []
tags: []
author: ""
toc: false
---

https://medium.com/rungo/making-external-http-requests-in-go-eb4c015f8839
https://medium.com/@masnun/making-http-requests-in-golang-dd123379efe7
https://zetcode.com/golang/getpostrequest/


The most fundamental purpose of the web is to transfer information. Currently, the most popular format for this is in JSON (Javascript Object Notation) - though this could change in the future.  If you are uncomfortable working with JSON in Go I suggest learning more about that first before continuing on.

<!--more-->

The `net/http` provides some out-of-the-box functions to use such as for the `GET` or `POST` requests since they are the most popular. However, many requests will require something more robust.


## HTTP GET
The following is the most basic Go GET request.

```go
import (
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	res, err := http.Get("https://httpbin.org/get")
	if err != nil {
		log.Fatal(err)
	}

	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	log.Println(string(body))
}
```

It is important to always remember to close the client when finished. We can make use of `defer res.Body.Close()` so that it will auto close at the end of the function.

### With Query Parameters

Since the data is included with the URL, we don't need to complicate the request by serializing it any way in the body. We do, however, need to make sure to escape any characters that need escaping.

```go
import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"
    "net/url"
)

func main() {

    book := "The Way of Kings"
    author := "Brandon Sanderson"
    params := "book=" + url.QueryEscape(book) + "&" +
        "author=" + url.QueryEscape(author)

    path := fmt.Sprintf("https://httpbin.org/get?%s", params)

    res, err := http.Get(path)
    if err != nil {
        log.Fatal(err)
    }

    defer res.Body.Close()

    body, err := ioutil.ReadAll(res.Body)
    if err != nil {
        log.Fatal(err)
    }

    log.Println(string(body))
}
```

## HTTP POST

The biggest challenge with Post requests is handling the JSON response (or sometimes the payload). The easiest way to interact with JSON in Go is through `structs`, `maps`, or `interfaces`. 

### With JSON Data

```go
import (
    "bytes"
    "encoding/json"
    "fmt"
    "log"
    "net/http"
)

func main() {

    values := map[string]string{"book": "The Way of Kings", "author": "Brandon Sanderson"}
    payload, err := json.Marshal(values)
    if err != nil {
        log.Fatal(err)
    }

    res, err := http.Post("https://httpbin.org/post", "application/json",
        bytes.NewBuffer(payload))
    if err != nil {
        log.Fatal(err)
    }

    var result map[string]interface{}
    json.NewDecoder(res.Body).Decode(&result)
    fmt.Println(result["json"])
}
```

### With FORM Data

Go has wrapper around it's Post method that is specific for dealing with form data. The only difference is that it will specify the header Content-Type as `application/x-www-form-urlencoded`.

```go
import (
    "encoding/json"
    "fmt"
    "log"
    "net/http"
    "net/url"
)

func main() {

    payload := url.Values{
        "book":   {"The Way of Kings"},
        "author": {"Brandon Sanderson"},
    }

    res, err := http.PostForm("https://httpbin.org/post", payload)
    if err != nil {
        log.Fatal(err)
    }

    var result map[string]interface{}
    json.NewDecoder(res.Body).Decode(&result)
    fmt.Println(result["form"])
}
```

## Customizing Requests

```go
import (
	"net/url"
	"net/http"
	"fmt"
	"log"
	"io/ioutil"
	"strings"
)

func main() {
	reqBody := map[string]string{"book": "The Way of Kings", "author": "Brandon Sanderson"}
    payload, err := json.Marshal(values)

	// create a request object
	req := &http.Request {
		Method: "POST",
		URL: "http://dummy.restapiexample.com/api/v1/create",
		Header: map[string][]string {
			"Content-Type": { "application/json; charset=UTF-8" },
		},
		Body: reqBody,
	}
	
	// send an HTTP request using `req` object
	res, err := http.DefaultClient.Do( req )

	// check for response error
	if err != nil {
		log.Fatal( "Error:", err )
	}

	// read response body
	data, _ := ioutil.ReadAll( res.Body )

	// close response body
	res.Body.Close()

	// print response status and body
	fmt.Printf( "status: %d\n", res.StatusCode )
	fmt.Printf( "body: %s\n", data )
}
```
