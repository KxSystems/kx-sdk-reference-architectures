.example.daAPI:{[table;column;multiplier;startTS;endTS]
    args:`table`startTS`endTS`agg!(table;startTS;endTS;enlist[column]!enlist column);
    data:@[.kxi.selectTable; args; {x}];
    res:?[data;();0b;`original_col`multiplied_col!(column;(*;column;multiplier))];
    (multiplier;res)
    };
.da.registerAPI[`.example.daAPI;
    .sapi.metaDescription["Example API"],
    .sapi.metaParam[`name`type`isReq`description!(`table;-11h;1b;"Table to query")],
    .sapi.metaParam[`name`type`isReq`description!(`column;-11h;1b;"Column to multiply")],
    .sapi.metaParam[`name`type`isReq`description!(`multiplier;-7h;1b;"Multiplier")],
    .sapi.metaParam[`name`type`isReq`description!(`scope;-99h;0b;"Workaround")],
    .sapi.metaReturn[`type`description!(98h;"Result of the select.")],
    .sapi.metaMisc[enlist[`safe]!enlist 1b]
    ];
