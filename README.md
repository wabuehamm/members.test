# Wabue Elgg test suite

## Introduction

This repository contains a test suite for the Wabue membership area based on Elgg.

## Prerequisites

Required modules:

* [File Transport](https://packagist.org/packages/wabuehamm/filetransport)
* [Wabue Hamm Plugin](https://github.com/wabuehamm/elgg-plugin-wabue)

Activate test mode after installing and activating both modules:

     php vendor/bin/elgg-cli wabue:testmode -t on

## Usage

To run the test suite you have to set the following 
[environment variables](https://docs.cypress.io/guides/guides/environment-variables.html):

* CYPRESS_baseurl: The URL to the Elgg instance
* CYPRESS_admin_username: The username of a membership admin
* CYPRESS_admin_password: The password of a membership admin
* CYPRESS_viewtype: Either desktop or mobile for desktop or mobile tests

```
npx cypress run
```
