# Waldbühne Digitaler Mitgliederbereich Testsuite

## Introduction

This repository holds test suites for the [Robot Framework](https://robotframework.org), that test the overall functionality of the digital members area of the [Waldbühne Heessen](https://waldbuehne-heessen.de)

## Requirements

* [Python](https://python.org) 3

## Installation

Start by creating a virtualenv inside the project directory

    python3 -m venv --copies venv

Then install the required dependencies

    venv/bin/pip install -r requirements.txt

Lastly, install the require browser drivers

    venv/bin/webdrivermanager chrome

## Usage

To start the test suites, copy the env.template file to .env and adjust it to your needs

    cp env.template .env
    ${EDITOR} .env

For screenshot comparison features, download the current screenshot collection from the google drive into the directory screenshots-baseline. (This is an internal process and not published)

Afterwards, run the test suites using

    bash mkdocs.sh

All output is saved into a directory output.

    output/imagediff.txt => Difference output between the baseline and the current screenshots
    output/desktop/report.html => Desktop Test report
    output/mobile/report.html => Mobile Test report

## Caveats

* To test the ical export features, the test suite downloads the exported file and assumes, that the file is downloaded into the user's usual download directory (~/Downloads on macOS and common Linux distributions). To change this path, set the environment variable TEST_DOWNLOAD_DIR.