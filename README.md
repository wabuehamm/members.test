# Wabue Elgg test suite

## Introduction

This repository contains a test suite for the Wabue membership area based on Elgg.

## Prerequisites

Turn off CSRF protection for the site by removing these two lines 
from `vendor/elgg/elgg/engine/classes/Elgg/ActionsService.php`:

```php
96      if (!in_array($action, self::$bypass_csrf)) {
97        $middleware[] = CsrfFirewall::class;
98      }
```

(_line numbers taken from Elgg 3.2.2_)

Also, the file transport plugin version 0.1.0 or higher needs to be installed and activated.

## Usage

To run the test suite you have to set the following 
[environment variables](https://docs.cypress.io/guides/guides/environment-variables.html):

* admin_username: The username of a membership admin
* admin_password: THe password of a membership admin

```
npx cypress run
```
