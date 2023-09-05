module fa
(input a,b,cin,
output s,cout
);

wire c1,c2,c3;
xor g1(s,a,b,cin);

and g2(c1,a,b),
	g3(c2,b,cin),
	g4(c3,cin,a);

or g5(cout,c1,c2,c3);
	
endmodule

module fbas
(input k,a0,a1,a2,a3,b0,b1,b2,b3,output s0,s1,s2,s3,cout);

wire xb0,xb1,xb2,xb3,c0,c1,c2;

xor g1(xb0,k,b0),
	g2(xb1,k,b1),
	g3(xb2,k,b2),
	g4(xb3,k,b3);

fa f1(a0,xb0,k,s0,c0),
	f2(a1,xb1,c0,s1,c1),
	f3(a2,xb2,c1,s2,c2),
	f4(a3,xb3,c2,s3,cout);
	
endmodule

module fbas_tb;

reg k,a0,a1,a2,a3,b0,b1,b2,b3;
wire s0,s1,s2,s3,cout;
integer fd;

fbas f1(k,a0,a1,a2,a3,b0,b1,b2,b3,s0,s1,s2,s3,cout);
reg [4:0] cnt1,cnt2;

initial
begin
	for(cnt1 = 0;cnt1<16;cnt1 = cnt1 + 1)
	begin
		for(cnt2 = 0;cnt2<16;cnt2 = cnt2 + 1)
		begin
		{a3,a2,a1,a0} = cnt1;
		{b3,b2,b1,b0} = cnt2;
		k = 0;
		#10;
		k = 1;
		#10;
		end
	end
end

initial 
begin
	fd = $fopen("fbas_out.txt");
	$fmonitor (fd,$time," a3=%b a2=%b a1=%b a0=%b b3=%b b2=%b b1=%b b0=%b s3=%b s2=%b s1=%b s0=%b cout=%b",a3,a2,a1,a0,b3,b2,b1,b0,s3,s2,s1,s0,cout);
end

endmodule


