# kdb Visual Studio Code Extension

## Introduction
This guide shows you how to query kdb Insights using the KX [kdb Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=KX.kdb).

## Pre-requisite
* KDB+/KDB-X available locally
* The kdb Insights is running
* [Visual Studio Code](https://code.visualstudio.com/) is installed
* An up to date version of the kdb Visual Studio Code extension is installed

## Walkthrough
The following steps describe how to start a [Kx REPL session](https://code.kx.com/vscode/get-started/repl.html) and use it to execute a q script which queries kdb Insights using the [`getData` API](https://code.kx.com/insights/api/database/query/get-data.html).

You require q being installed on your path to run 
1. Launch VS Code and start a REPL session from the Command Palette by searching for >KX:Start REPL.
1. Open the `sample.q` file and 'Choose Connection' -> REPL
1. Right click on the Editor and select "Execute Entire File"
1. The results (i.e. taxi table data) should be displayed in the "kdb Results" section of the Status Bar

## Links
* [Visual Studio Code User Interface | code.visualstudio.com](https://code.visualstudio.com/docs/getstarted/userinterface)
