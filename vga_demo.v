`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module vga_demo(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, Sw0, Sw1, btnU, btnD, btnL, btnR,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7);
	input ClkPort, Sw0, btnU, btnD, Sw0, Sw1, btnR, btnL;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, ClkPort, board_clk, clk, button_clk;
	
	BUF BUF1 (board_clk, ClkPort); 	
	BUF BUF2 (reset, Sw0);
	BUF BUF3 (start, Sw1);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];
	assign	clk = DIV_CLK[1];
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	function collision;
	    input Xposition_player, Yposition_player, 
	    	Xposition_block11, Xposition_block12,
	    	Xposition_block21, Xposition_block22,
	    	Xposition_block31, Xposition_block32,
	    	Xposition_block41, Xposition_block42, 
	    	Xposition_block51, Xposition_block52,
	    	Xposition_block61, Xposition_block62; 
	    begin
			// Demonstrates driving external Global Reg
			if((Xposition_block11 < Xposition_player + 30) && (Xposition_block11 > Xposition_player - 30) && (Yposition_player == 60))
				collision = 1;
			else if ((Xposition_block12 < Xposition_player + 30) && (Xposition_block12 > Xposition_player - 30) && (Yposition_player == 60))
				collision = 1;
			else if((Xposition_block21 < Xposition_player + 30) && (Xposition_block21 > Xposition_player - 30) && (Yposition_player == 120))
				collision = 1;
			else if((Xposition_block22 < Xposition_player + 30) && (Xposition_block22 > Xposition_player - 30) && (Yposition_player == 120))
				collision = 1;
			else if((Xposition_block31 < Xposition_player + 30) && (Xposition_block31 > Xposition_player - 30) && (Yposition_player == 180))
				collision = 1;
			else if ((Xposition_block32 < Xposition_player + 30) && (Xposition_block32 > Xposition_player - 30) && (Yposition_player == 180))
				collision = 1;
			else if ((Xposition_block41 < Xposition_player + 30) && (Xposition_block41 > Xposition_player - 30) && (Yposition_player == 240))
				collision = 1;
			else if ((Xposition_block42 < Xposition_player + 30) && (Xposition_block42 > Xposition_player - 30) && (Yposition_player == 240))
				collision = 1;
			else if ((Xposition_block51 < Xposition_player + 30) && (Xposition_block51 > Xposition_player - 30) && (Yposition_player == 300))
				collision = 1;
			else if ((Xposition_block52 < Xposition_player + 30) && (Xposition_block52 > Xposition_player - 30) && (Yposition_player == 300))
				collision = 1;
			else if ((Xposition_block61 < Xposition_player + 30) && (Xposition_block61 > Xposition_player - 30) && (Yposition_player == 360))
				collision = 1;
			else if ((Xposition_block62 < Xposition_player + 30) && (Xposition_block62 > Xposition_player - 30) && (Yposition_player == 360))
				collision = 1;
			else if ((Yposition_player > 420))
				collision = 2;
			else 
				collision = 0;
	    end
  	endfunction
	
	reg[19:0] row1; // Starting row
	reg[19:0] row2;
	reg[19:0] row3;
	reg[19:0] row4;
	reg[19:0] row5;
	reg[19:0] row6;
	reg[19:0] row7;
	reg[19:0] row8;
	reg[19:0] row9;
	reg[19:0] row10;
	reg[19:0] row11;
	reg[19:0] row12;
	reg[19:0] row13;
	reg[19:0] row14;
	reg[19:0] row15; // Ending row
	

	reg [9:0] Xposition_player;
	reg [9:0] Yposition_player;
	reg [9:0] Xposition_block11;
	reg [9:0] Xposition_block12;
	reg [9:0] Xposition_block21;
	reg [9:0] Xposition_block22;
	reg [9:0] Xposition_block31;
	reg [9:0] Xposition_block32;
	reg [9:0] Xposition_block41;
	reg [9:0] Xposition_block42;
	reg [9:0] Xposition_block51;
	reg [9:0] Xposition_block52;
	reg [9:0] Xposition_block61;
	reg [9:0] Xposition_block62;
	reg [9:0] Yposition_block1;
	reg [9:0] Yposition_block2;
	reg [9:0] Yposition_block3;
	reg [9:0] Yposition_block4;
	reg [9:0] Yposition_block5;
	reg [9:0] Yposition_block6;
	
	always @(posedge DIV_CLK[21])
		begin
			/* Xposition_block11 <= Xposition_block11 + 10;
			Xposition_block21 <= Xposition_block21 + 10;
			Xposition_block31 <= Xposition_block31 + 10;
			Xposition_block41 <= Xposition_block41 + 10;
			Xposition_block51 <= Xposition_block51 + 10;
			Xposition_block61 <= Xposition_block61 + 10; */
			row2 <= {row2[0], row2[19:1]};
			row3 <= {row3[0], row3[19:1]};
			row4 <= {row4[18:0], row4[19]};
			row5 <= {row5[18:0], row5[19]};
			row6 <= {row6[0], row6[19:1]};
			row7 <= {row7[0], row7[19:1]};
			row8 <= {row8[18:0], row8[19]};
			row9 <= {row9[18:0], row9[19]};
			row10 <= {row10[0], row10[19:1]};
			row11 <= {row11[0], row11[19:1]};
			row12 <= {row12[18:0], row12[19]};
			row13 <= {row13[0], row13[19:1]};
			row14 <= {row14[18:0], row14[19]};
			
			if(reset)
				begin
 					Xposition_player<=320;	// middle of screen
					Yposition_player<=480;  // bottom of screen
/*					Yposition_block1 <= 60;
					Yposition_block2 <= 120;
					Yposition_block3 <= 180;
					Yposition_block4 <= 240;
					Yposition_block5 <= 300;
					Yposition_block6 <= 360;
					Xposition_block11 <= 0;   // start on far left of the screen
					Xposition_block21 <= 120;
					Xposition_block31 <= 240;
					Xposition_block41 <= 360;
					Xposition_block51 <= 480;
					Xposition_block61 <= 600;
 */					row1 <= 20'b00000000000000000000; // Starting row
					row2 <= 20'b00000000000000000000;
					row3 <= 20'b00000000000000000000;
					row4 <= 20'b00000000000000000000;
					row5 <= 20'b00000000000000000000;
					row6 <= 20'b00000000000000000000;
					row7 <= 20'b00000000000000000000;
					row8 <= 20'b00000000000000000000;
					row9 <= 20'b00000000000000000000;
					row10 <= 20'b00000000000000000000;
					row11 <= 20'b00000000000000000000;
					row12 <= 20'b00000000000000000000;
					row13 <= 20'b00000000000000000000;
					row14 <= 20'b00000000000000000000;
					row15 <= 20'b00000000000000000000; // Ending row
				end
			else if(btnD && ~btnU)
				Yposition_player<=Yposition_player+60;
			else if(btnU && ~btnD)
				Yposition_player<=Yposition_player-60;

			/* if(Xposition_block11 == 640)
				Xposition_block11 <= 0;
			if(Xposition_block21 == 640)
				Xposition_block21 <= 0;
			if(Xposition_block31 == 640)
				Xposition_block31 <= 0;
			if(Xposition_block41 == 640)
				Xposition_block41 <= 0;
			if(Xposition_block51 == 640)
				Xposition_block51 <= 0;
			if(Xposition_block61 == 640)
				Xposition_block61 <= 0; */
		end

	wire R = (CounterY[9:5]=14 && row2[CounterX[9:5]]
	wire G = CounterY>=(Yposition_player) && CounterY<=(Yposition_player+32) && 
	CounterX>=(Xposition_player - 16) && CounterX<=(Xposition_player +16);
	/* (CounterY>Yposition_block1 && CounterY<(Yposition_block1 + 60) && 
	CounterX>Xposition_block11 && CounterX<(20 + Xposition_block11)) || 
	(CounterY>Yposition_block2 && CounterY<(Yposition_block2 + 60) && 
	CounterX>Xposition_block21 && CounterX<(20 + Xposition_block21)) ||
	(CounterY>Yposition_block3 && CounterY<(Yposition_block3 + 60) && 
	CounterX>Xposition_block31 && CounterX<(20 + Xposition_block31)) ||
	(CounterY>Yposition_block4 && CounterY<(Yposition_block4 + 60) && 
	CounterX>Xposition_block41 && CounterX<(20 + Xposition_block41)) ||
	(CounterY>Yposition_block5 && CounterY<(Yposition_block5 + 60) && 
	CounterX>Xposition_block51 && CounterX<(20 + Xposition_block51)) ||
	(CounterY>Yposition_block6 && CounterY<(Yposition_block6 + 60) && 
	CounterX>Xposition_block61 && CounterX<(20 + Xposition_block61)); */
	wire B = 0;
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	`define QI 			2'b00
	`define QGAME_1 	2'b01
	`define QGAME_2 	2'b10
	`define QDONE 		2'b11
	
	reg [3:0] p2_score;
	reg [3:0] p1_score;
	reg [1:0] state;
	wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	assign LD0 = (p1_score == 4'b1010);
	assign LD1 = (p2_score == 4'b1010);
	
	assign LD2 = start;
	assign LD4 = reset;
	
	assign LD3 = (state == `QI);
	assign LD5 = (state == `QGAME_1);	
	assign LD6 = (state == `QGAME_2);
	assign LD7 = (state == `QDONE);
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	wire 	[1:0] ssdscan_clk;
	
	assign SSD3 = 4'b1111;
	assign SSD2 = 4'b1111;
	assign SSD1 = 4'b1111;
	assign SSD0 = 4'b1111;
	
	// need a scan clk for the seven segment display 
	// 191Hz (50MHz / 2^18) works well
	assign ssdscan_clk = DIV_CLK[19:18];	
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
			2'b00:
					SSD = SSD0;
			2'b01:
					SSD = SSD1;
			2'b10:
					SSD = SSD2;
			2'b11:
					SSD = SSD3;
		endcase 
	end	

	// and finally convert SSD_num to ssd
	reg [6:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD)		
			4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
			4'b0000: SSD_CATHODES = 7'b0000001 ; //0
			4'b0001: SSD_CATHODES = 7'b1001111 ; //1
			4'b0010: SSD_CATHODES = 7'b0010010 ; //2
			4'b0011: SSD_CATHODES = 7'b0000110 ; //3
			4'b0100: SSD_CATHODES = 7'b1001100 ; //4
			4'b0101: SSD_CATHODES = 7'b0100100 ; //5
			4'b0110: SSD_CATHODES = 7'b0100000 ; //6
			4'b0111: SSD_CATHODES = 7'b0001111 ; //7
			4'b1000: SSD_CATHODES = 7'b0000000 ; //8
			4'b1001: SSD_CATHODES = 7'b0000100 ; //9
			4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
			default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
		endcase
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
endmodule

// module function_example ();
 
//   reg r_Bit1=1'b1, r_Bit2=1'b0, r_Bit3=1'b1;
//   wire w_Result;
//   reg  r_Global;
 
//   function do_math;
//     input i_bit1, i_bit2, i_bit3; 
//     reg   v_Temp; // Local Variable
//     begin
//       // Demonstrates driving external Global Reg
//       r_Global = 1'b1; 
       
//       v_Temp  = (i_bit1 & i_bit2);
//       do_math = (v_Temp | i_bit3);
//     end
//   endfunction
 
//   assign w_Result = do_math(r_Bit1, r_Bit2, r_Bit3);
 
// endmodule
