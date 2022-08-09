divert(-1)

dnl Define the macro for buffer widget

dnl N_BUFFER(name)
define(`N_BUFFER', `BUF'PIPELINE_ID`.'$1)

dnl W_BUFFER(name, size, capabilities, reference_tag)
define(`W_BUFFER',
`SectionVendorTuples."'N_BUFFER($1)`_tuples" {'
`	tokens "sof_buffer_tokens"'
`	tuples."word" {'
`		SOF_TKN_BUF_SIZE'	STR($2)
`		SOF_TKN_BUF_CAPS'	STR($3)
`ifelse(`$#', `4',
`		SOF_TKN_BUF_REFERENCE'	STR($4)
,` ')'
`	}'
`}'
`SectionData."'N_BUFFER($1)`_data" {'
`	tuples "'N_BUFFER($1)`_tuples"'
`}'
`SectionWidget."'N_BUFFER($1)`" {'
`	index "'PIPELINE_ID`"'
`	type "buffer"'
`	no_pm "true"'
`	data ['
`		"'N_BUFFER($1)`_data"'
`	]'
`}')

dnl COMP_BUFFER_SIZE( num_periods, sample_size, channels, fmames)
define(`COMP_BUFFER_SIZE', `eval(`$1 * $2 * $3 * $4')')

dnl COMP_PERIOD_FRAMES( sample_rate, period_us)
define(`COMP_PERIOD_FRAMES', `eval(`($1 * $2) / 1000000')')

divert(0)dnl
