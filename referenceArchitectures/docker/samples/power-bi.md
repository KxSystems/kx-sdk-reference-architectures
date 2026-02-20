# Power BI

## Introduction
This guide show how to query kdb Insights using [Power BI](https://www.microsoft.com/en-us/power-platform/products/power-bi) and the [`getData` API](https://code.kx.com/insights/api/database/query/get-data.html).

## Pre-requisite
* The kdb Insights must be deployed before attempting the walkthrough.
* [Power BI Desktop](https://powerbi.microsoft.com/en-us/desktop/) is installed.

## Walkthrough
1. Launch Power BI Desktop.
2. Click the *'Get data'* button, under the Home menu, and select *'Blank query'*.
3. In the new Power Query Editor window click the *'Advanced Editor'* button under the Home menu.
4. Copy and paste the query below into the Advanced Editor window
```PowerQuery
let
    url = " http://localhost:8080/data",
    headers = [#"Content-Type" = "application/json"],
    body = Json.FromValue([table = "taxi"]),
    response = Web.Contents(
        url,
        [
            Headers = headers,
            Content = body
        ]
    ),
    doc = Json.Document(response),
    payload = doc[payload],
    #"Converted to table" = Table.FromList(payload, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to table", "Column1", {"vendor", "pickup", "dropoff", "passengers", "distance", "fare", "extra", "tax", "tip", "tolls", "fees", "total", "payment_type"})
in
    #"Expanded Column1"
```
5. Press the *Done* button.

## Links
* [Power Query M formula language - PowerQuery M | Microsoft Learn](https://learn.microsoft.com/en-us/powerquery-m/)
* [Web.Contents - PowerQuery M | Microsoft Learn](https://learn.microsoft.com/en-us/powerquery-m/web-contents)
* [Json.FromValue - PowerQuery M | Microsoft Learn](https://learn.microsoft.com/en-us/powerquery-m/json-fromvalue)
