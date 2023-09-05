module ha
(input a,b,
output s,c);

xor g1(s,a,b);

and g2(c,a,b);

endmodule

module fa
(input a,b,cin,
output s,c
);

wire c1,c2,c3;

xor g1(s,a,b,cin);

and g2(c1,a,b),
	g3(c2,b,cin),
	g4(c3,cin,a);
	
or g5(c,c1,c2,c3);

endmodule

module rca
(input a0,b0,a1,b1,a2,b2,a3,b3,
output s0,s1,s2,s3,cout
);

wire c0,c1,c2;

ha h1(a0,b0,s0,c0);

fa f1(a1,b1,c0,s1,c1),
	f2(a2,b2,c1,s2,c2),
	f3(a3,b3,c2,s3,cout);
	
endmodule

module rca_tb;
reg a0,a1,a2,a3,b0,b1,b2,b3;
wire s0,s1,s2,s3,cout;

rca r1(a0,b0,a1,b1,a2,b2,a3,b3,s0,s1,s2,s3,cout);
reg [4:0] cnt1;
reg [4:0] cnt2;

initial
begin
	for(cnt1 = 0;cnt1<16;cnt1 = cnt1 + 1)
	begin
		for(cnt2 = 0;cnt2<16;cnt2 = cnt2 + 1)
		begin
		{a3,a2,a1,a0} = cnt1;
		{b3,b2,b1,b0} = cnt2;
		#10;
		end
	end
end

endmodule
	
	

