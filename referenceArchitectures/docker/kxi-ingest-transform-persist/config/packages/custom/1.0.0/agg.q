.example.aggAPI:{[tbls]
    razed:raze last each tbls;
    res:select original_col, multiplied_col_avg: avgs multiplied_col from razed;
    .sapi.ok res
    };
.sgagg.registerAggFn[`.example.aggAPI;
    .sapi.metaDescription["Average aggregator"],
    .sapi.metaParam[`name`type`description!(`tbls;0h;"Tables received from DAPs")],
    .sapi.metaReturn`type`description!(98h;"Running average of multiplied column");
    `.example.daAPI
    ];
