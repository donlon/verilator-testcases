typedef int mytype_0;
typedef int mytype_1;

module lookahead;

	typedef int mytype;

	// input  a logic

	initial begin
		// mytype begin t; // unexpected begin, expecting IDENTIFIER or TYPE_IDENTIFIER or NETTYPE_IDENTIFIER or '='.
		int a [1]; // unexpected begin, expecting IDENTIFIER or TYPE_IDENTIFIER or NETTYPE_IDENTIFIER or '='.
		// int mytype;
	end

endmodule : lookahead

module m2 (
	input mytype_0 a[10],
	input mytype_0 b,
	// input mytype_0[] c,
	input name[10],
	input mytype_1[10],
	input mytype_1[10] c
	input mytype_1[10] c, d
);

endmodule : m2