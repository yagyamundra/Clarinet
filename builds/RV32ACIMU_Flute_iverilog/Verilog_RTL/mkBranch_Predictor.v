//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40db, 2019-05-24)
//
//
//
//
// Ports:
// Name                         I/O  size props
// RDY_reset                      O     1 const
// RDY_predict_req                O     1
// predict_rsp                    O    32
// RDY_bp_train                   O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// predict_req_pc                 I    32 reg
// predict_rsp_is_i32_not_i16     I     1
// predict_rsp_instr              I    32
// bp_train_pc                    I    32
// bp_train_is_i32_not_i16        I     1
// bp_train_instr                 I    32
// bp_train_cf_info               I    99
// EN_reset                       I     1
// EN_predict_req                 I     1
// EN_bp_train                    I     1
//
// Combinational paths from inputs to outputs:
//   (predict_rsp_is_i32_not_i16, predict_rsp_instr) -> predict_rsp
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkBranch_Predictor(CLK,
			  RST_N,

			  EN_reset,
			  RDY_reset,

			  predict_req_pc,
			  EN_predict_req,
			  RDY_predict_req,

			  predict_rsp_is_i32_not_i16,
			  predict_rsp_instr,
			  predict_rsp,

			  bp_train_pc,
			  bp_train_is_i32_not_i16,
			  bp_train_instr,
			  bp_train_cf_info,
			  EN_bp_train,
			  RDY_bp_train);
  input  CLK;
  input  RST_N;

  // action method reset
  input  EN_reset;
  output RDY_reset;

  // action method predict_req
  input  [31 : 0] predict_req_pc;
  input  EN_predict_req;
  output RDY_predict_req;

  // value method predict_rsp
  input  predict_rsp_is_i32_not_i16;
  input  [31 : 0] predict_rsp_instr;
  output [31 : 0] predict_rsp;

  // action method bp_train
  input  [31 : 0] bp_train_pc;
  input  bp_train_is_i32_not_i16;
  input  [31 : 0] bp_train_instr;
  input  [98 : 0] bp_train_cf_info;
  input  EN_bp_train;
  output RDY_bp_train;

  // signals for module outputs
  wire [31 : 0] predict_rsp;
  wire RDY_bp_train, RDY_predict_req, RDY_reset;

  // register rg_index
  reg [8 : 0] rg_index;
  wire [8 : 0] rg_index$D_IN;
  wire rg_index$EN;

  // register rg_pc
  reg [31 : 0] rg_pc;
  wire [31 : 0] rg_pc$D_IN;
  wire rg_pc$EN;

  // register rg_ras
  reg [511 : 0] rg_ras;
  wire [511 : 0] rg_ras$D_IN;
  wire rg_ras$EN;

  // register rg_resetting
  reg rg_resetting;
  wire rg_resetting$D_IN, rg_resetting$EN;

  // ports of submodule btb_bramcore2
  wire [53 : 0] btb_bramcore2$DIA, btb_bramcore2$DIB, btb_bramcore2$DOA;
  wire [8 : 0] btb_bramcore2$ADDRA, btb_bramcore2$ADDRB;
  wire btb_bramcore2$ENA,
       btb_bramcore2$ENB,
       btb_bramcore2$WEA,
       btb_bramcore2$WEB;

  // ports of submodule rf_btb_fsms
  wire [8 : 0] rf_btb_fsms$ADDR_1,
	       rf_btb_fsms$ADDR_2,
	       rf_btb_fsms$ADDR_3,
	       rf_btb_fsms$ADDR_4,
	       rf_btb_fsms$ADDR_5,
	       rf_btb_fsms$ADDR_IN;
  wire [1 : 0] rf_btb_fsms$D_IN, rf_btb_fsms$D_OUT_1;
  wire rf_btb_fsms$WE;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_reset,
       CAN_FIRE_bp_train,
       CAN_FIRE_predict_req,
       CAN_FIRE_reset,
       WILL_FIRE_RL_rl_reset,
       WILL_FIRE_bp_train,
       WILL_FIRE_predict_req,
       WILL_FIRE_reset;

  // inputs to muxes for submodule ports
  reg [1 : 0] MUX_rf_btb_fsms$upd_2__VAL_1;
  wire [53 : 0] MUX_btb_bramcore2$b_put_3__VAL_1;
  wire [8 : 0] MUX_rg_index$write_1__VAL_2;
  wire MUX_btb_bramcore2$b_put_1__SEL_1;

  // remaining internal signals
  reg [31 : 0] _theResult_____1_fst__h7540,
	       _theResult_____1_fst__h7584,
	       pred_PC__h7445;
  reg [1 : 0] _theResult_____1_snd__h7541, _theResult_____1_snd__h7585;
  wire [511 : 0] IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d229,
		 IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d231;
  wire [479 : 0] IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d225;
  wire [31 : 0] _theResult_____1__h2391,
		_theResult_____1_fst__h7473,
		_theResult____h2390,
		pred_pc__h3362,
		pred_pc__h3364,
		ret_pc___1__h4117,
		ret_pc__h4079;
  wire [1 : 0] _theResult_____1_snd__h7474;
  wire IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d192,
       IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d195,
       IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d218,
       IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d205,
       IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d210,
       IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d220,
       IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d147,
       IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d162,
       IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d174,
       IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d76,
       IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d93,
       IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d38,
       IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d55,
       IF_predict_rsp_is_i32_not_i16_THEN_predict_rsp_ETC___d62,
       IF_predict_rsp_is_i32_not_i16_THEN_predict_rsp_ETC___d87,
       NOT_bp_train_instr_BITS_11_TO_7_28_EQ_bp_train_ETC___d215,
       NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1000__ETC___d137,
       NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1001__ETC___d142,
       NOT_predict_rsp_instr_BITS_11_TO_7_1_EQ_predic_ETC___d90,
       bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d169,
       bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d217,
       bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_O_ETC___d187,
       bp_train_instr_BITS_15_TO_12_25_EQ_0b1001_38_A_ETC___d157,
       predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d29,
       predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d92,
       predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1001_0__ETC___d33;

  // action method reset
  assign RDY_reset = 1'd1 ;
  assign CAN_FIRE_reset = 1'd1 ;
  assign WILL_FIRE_reset = EN_reset ;

  // action method predict_req
  assign RDY_predict_req = !rg_resetting ;
  assign CAN_FIRE_predict_req = !rg_resetting ;
  assign WILL_FIRE_predict_req = EN_predict_req ;

  // value method predict_rsp
  assign predict_rsp =
	     (_theResult_____1__h2391 == 32'hFFFFFFFF) ?
	       pred_pc__h3364 :
	       _theResult_____1__h2391 ;

  // action method bp_train
  assign RDY_bp_train = 1'd1 ;
  assign CAN_FIRE_bp_train = 1'd1 ;
  assign WILL_FIRE_bp_train = EN_bp_train ;

  // submodule btb_bramcore2
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd9),
	  .DATA_WIDTH(32'd54),
	  .MEMSIZE(10'd512)) btb_bramcore2(.CLKA(CLK),
					   .CLKB(CLK),
					   .ADDRA(btb_bramcore2$ADDRA),
					   .ADDRB(btb_bramcore2$ADDRB),
					   .DIA(btb_bramcore2$DIA),
					   .DIB(btb_bramcore2$DIB),
					   .WEA(btb_bramcore2$WEA),
					   .WEB(btb_bramcore2$WEB),
					   .ENA(btb_bramcore2$ENA),
					   .ENB(btb_bramcore2$ENB),
					   .DOA(btb_bramcore2$DOA),
					   .DOB());

  // submodule rf_btb_fsms
  RegFile #(.addr_width(32'd9),
	    .data_width(32'd2),
	    .lo(9'h0),
	    .hi(9'd511)) rf_btb_fsms(.CLK(CLK),
				     .ADDR_1(rf_btb_fsms$ADDR_1),
				     .ADDR_2(rf_btb_fsms$ADDR_2),
				     .ADDR_3(rf_btb_fsms$ADDR_3),
				     .ADDR_4(rf_btb_fsms$ADDR_4),
				     .ADDR_5(rf_btb_fsms$ADDR_5),
				     .ADDR_IN(rf_btb_fsms$ADDR_IN),
				     .D_IN(rf_btb_fsms$D_IN),
				     .WE(rf_btb_fsms$WE),
				     .D_OUT_1(rf_btb_fsms$D_OUT_1),
				     .D_OUT_2(),
				     .D_OUT_3(),
				     .D_OUT_4(),
				     .D_OUT_5());

  // rule RL_rl_reset
  assign CAN_FIRE_RL_rl_reset = rg_resetting ;
  assign WILL_FIRE_RL_rl_reset = rg_resetting && !EN_bp_train ;

  // inputs to muxes for submodule ports
  assign MUX_btb_bramcore2$b_put_1__SEL_1 =
	     EN_bp_train && pred_PC__h7445 != 32'hFFFFFFFF ;
  assign MUX_btb_bramcore2$b_put_3__VAL_1 =
	     { 1'd1, bp_train_cf_info[96:75], pred_PC__h7445[31:1] } ;
  always@(bp_train_cf_info or
	  rf_btb_fsms$D_OUT_1 or _theResult_____1_snd__h7474)
  begin
    case (bp_train_cf_info[98:97])
      2'd0: MUX_rf_btb_fsms$upd_2__VAL_1 = _theResult_____1_snd__h7474;
      2'd1, 2'd2: MUX_rf_btb_fsms$upd_2__VAL_1 = 2'b11;
      2'd3: MUX_rf_btb_fsms$upd_2__VAL_1 = rf_btb_fsms$D_OUT_1;
    endcase
  end
  assign MUX_rg_index$write_1__VAL_2 = rg_index + 9'd1 ;

  // register rg_index
  assign rg_index$D_IN = EN_reset ? 9'd0 : MUX_rg_index$write_1__VAL_2 ;
  assign rg_index$EN = WILL_FIRE_RL_rl_reset || EN_reset ;

  // register rg_pc
  assign rg_pc$D_IN = predict_req_pc ;
  assign rg_pc$EN = EN_predict_req ;

  // register rg_ras
  assign rg_ras$D_IN =
	     (IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d147 &&
	      IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d162 ||
	      IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d174 &&
	      IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d162 &&
	      (IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d192 ||
	       IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d195)) ?
	       IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d229 :
	       IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d231 ;
  assign rg_ras$EN = EN_bp_train ;

  // register rg_resetting
  assign rg_resetting$D_IN = EN_reset ;
  assign rg_resetting$EN =
	     WILL_FIRE_RL_rl_reset && rg_index == 9'd511 || EN_reset ;

  // submodule btb_bramcore2
  assign btb_bramcore2$ADDRA = predict_req_pc[9:1] ;
  assign btb_bramcore2$ADDRB =
	     MUX_btb_bramcore2$b_put_1__SEL_1 ?
	       bp_train_cf_info[74:66] :
	       rg_index ;
  assign btb_bramcore2$DIA = 54'h2AAAAAAAAAAAAA /* unspecified value */  ;
  assign btb_bramcore2$DIB =
	     MUX_btb_bramcore2$b_put_1__SEL_1 ?
	       MUX_btb_bramcore2$b_put_3__VAL_1 :
	       54'd0 ;
  assign btb_bramcore2$WEA = 1'd0 ;
  assign btb_bramcore2$WEB = 1'd1 ;
  assign btb_bramcore2$ENA = EN_predict_req ;
  assign btb_bramcore2$ENB =
	     EN_bp_train && pred_PC__h7445 != 32'hFFFFFFFF ||
	     WILL_FIRE_RL_rl_reset ;

  // submodule rf_btb_fsms
  assign rf_btb_fsms$ADDR_1 = bp_train_cf_info[74:66] ;
  assign rf_btb_fsms$ADDR_2 = 9'h0 ;
  assign rf_btb_fsms$ADDR_3 = 9'h0 ;
  assign rf_btb_fsms$ADDR_4 = 9'h0 ;
  assign rf_btb_fsms$ADDR_5 = 9'h0 ;
  assign rf_btb_fsms$ADDR_IN =
	     MUX_btb_bramcore2$b_put_1__SEL_1 ?
	       bp_train_cf_info[74:66] :
	       rg_index ;
  assign rf_btb_fsms$D_IN =
	     MUX_btb_bramcore2$b_put_1__SEL_1 ?
	       MUX_rf_btb_fsms$upd_2__VAL_1 :
	       2'b0 ;
  assign rf_btb_fsms$WE =
	     EN_bp_train && pred_PC__h7445 != 32'hFFFFFFFF ||
	     WILL_FIRE_RL_rl_reset ;

  // remaining internal signals
  assign IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d225 =
	     ((IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d205 ||
	       IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d210) &&
	      IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d174 &&
	      IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d220) ?
	       rg_ras[511:32] :
	       rg_ras[479:0] ;
  assign IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d229 =
	     { IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d225,
	       bp_train_is_i32_not_i16 ? ret_pc__h4079 : ret_pc___1__h4117 } ;
  assign IF_IF_bp_train_is_i32_not_i16_THEN_NOT_bp_trai_ETC___d231 =
	     ((IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d205 ||
	       IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d210) &&
	      IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d174 &&
	      IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d220) ?
	       { 32'hFFFFFFFF, rg_ras[511:32] } :
	       rg_ras ;
  assign IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d192 =
	     (bp_train_is_i32_not_i16 ||
	      (bp_train_instr[15:13] == 3'b101 ||
	       bp_train_instr[15:13] == 3'b001) &&
	      bp_train_instr[1:0] == 2'b01) ?
	       bp_train_instr[19:15] != 5'd1 &&
	       bp_train_instr[19:15] != 5'd5 :
	       (bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_O_ETC___d187 ?
		  bp_train_instr[11:7] != 5'd1 &&
		  bp_train_instr[11:7] != 5'd5 :
		  bp_train_instr[19:15] != 5'd1 &&
		  bp_train_instr[19:15] != 5'd5) ;
  assign IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d195 =
	     (bp_train_is_i32_not_i16 ||
	      (bp_train_instr[15:13] == 3'b101 ||
	       bp_train_instr[15:13] == 3'b001) &&
	      bp_train_instr[1:0] == 2'b01) ?
	       bp_train_instr[19:15] == 5'd1 ||
	       bp_train_instr[19:15] == 5'd5 :
	       (bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_O_ETC___d187 ?
		  bp_train_instr[11:7] == 5'd1 ||
		  bp_train_instr[11:7] == 5'd5 :
		  bp_train_instr[19:15] == 5'd1 ||
		  bp_train_instr[19:15] == 5'd5) ;
  assign IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d218 =
	     (bp_train_is_i32_not_i16 ||
	      (bp_train_instr[15:13] == 3'b101 ||
	       bp_train_instr[15:13] == 3'b001) &&
	      bp_train_instr[1:0] == 2'b01) ?
	       NOT_bp_train_instr_BITS_11_TO_7_28_EQ_bp_train_ETC___d215 :
	       bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d217 ;
  assign IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d205 =
	     bp_train_is_i32_not_i16 ?
	       bp_train_instr[6:0] != 7'b1101111 :
	       (bp_train_instr[15:13] != 3'b101 ||
		bp_train_instr[1:0] != 2'b01) &&
	       (bp_train_instr[15:13] != 3'b001 ||
		bp_train_instr[1:0] != 2'b01) &&
	       (bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d169 ||
		bp_train_instr_BITS_15_TO_12_25_EQ_0b1001_38_A_ETC___d157 ||
		bp_train_instr[6:0] != 7'b1101111) ;
  assign IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d210 =
	     bp_train_is_i32_not_i16 ?
	       bp_train_instr[11:7] != 5'd1 && bp_train_instr[11:7] != 5'd5 :
	       bp_train_instr[15:13] == 3'b101 &&
	       bp_train_instr[1:0] == 2'b01 ||
	       (bp_train_instr[15:13] != 3'b001 ||
		bp_train_instr[1:0] != 2'b01) &&
	       (bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d169 ||
		NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1001__ETC___d142 &&
		bp_train_instr[11:7] != 5'd1 &&
		bp_train_instr[11:7] != 5'd5) ;
  assign IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d220 =
	     IF_bp_train_is_i32_not_i16_THEN_NOT_bp_train_i_ETC___d210 &&
	     IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d195 ||
	     IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d162 &&
	     IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d195 &&
	     IF_bp_train_is_i32_not_i16_OR_bp_train_instr_B_ETC___d218 ;
  assign IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d147 =
	     bp_train_is_i32_not_i16 ?
	       bp_train_instr[6:0] == 7'b1101111 :
	       bp_train_instr[15:13] == 3'b101 &&
	       bp_train_instr[1:0] == 2'b01 ||
	       bp_train_instr[15:13] == 3'b001 &&
	       bp_train_instr[1:0] == 2'b01 ||
	       NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1000__ETC___d137 &&
	       NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1001__ETC___d142 &&
	       bp_train_instr[6:0] == 7'b1101111 ;
  assign IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d162 =
	     bp_train_is_i32_not_i16 ?
	       bp_train_instr[11:7] == 5'd1 || bp_train_instr[11:7] == 5'd5 :
	       (bp_train_instr[15:13] != 3'b101 ||
		bp_train_instr[1:0] != 2'b01) &&
	       (bp_train_instr[15:13] == 3'b001 &&
		bp_train_instr[1:0] == 2'b01 ||
		NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1000__ETC___d137 &&
		(bp_train_instr_BITS_15_TO_12_25_EQ_0b1001_38_A_ETC___d157 ||
		 bp_train_instr[11:7] == 5'd1 ||
		 bp_train_instr[11:7] == 5'd5)) ;
  assign IF_bp_train_is_i32_not_i16_THEN_bp_train_instr_ETC___d174 =
	     bp_train_is_i32_not_i16 ?
	       bp_train_instr[6:0] == 7'b1100111 :
	       (bp_train_instr[15:13] != 3'b101 ||
		bp_train_instr[1:0] != 2'b01) &&
	       (bp_train_instr[15:13] != 3'b001 ||
		bp_train_instr[1:0] != 2'b01) &&
	       (bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d169 ||
		bp_train_instr_BITS_15_TO_12_25_EQ_0b1001_38_A_ETC___d157 ||
		bp_train_instr[6:0] == 7'b1100111) ;
  assign IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d76 =
	     (predict_rsp_is_i32_not_i16 ||
	      (predict_rsp_instr[15:13] == 3'b101 ||
	       predict_rsp_instr[15:13] == 3'b001) &&
	      predict_rsp_instr[1:0] == 2'b01) ?
	       predict_rsp_instr[19:15] == 5'd1 ||
	       predict_rsp_instr[19:15] == 5'd5 :
	       (((predict_rsp_instr[15:12] == 4'b1000 ||
		  predict_rsp_instr[15:12] == 4'b1001) &&
		 predict_rsp_instr[11:7] != 5'd0 &&
		 predict_rsp_instr[6:2] == 5'd0 &&
		 predict_rsp_instr[1:0] == 2'b10) ?
		  predict_rsp_instr[11:7] == 5'd1 ||
		  predict_rsp_instr[11:7] == 5'd5 :
		  predict_rsp_instr[19:15] == 5'd1 ||
		  predict_rsp_instr[19:15] == 5'd5) ;
  assign IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d93 =
	     (predict_rsp_is_i32_not_i16 ||
	      (predict_rsp_instr[15:13] == 3'b101 ||
	       predict_rsp_instr[15:13] == 3'b001) &&
	      predict_rsp_instr[1:0] == 2'b01) ?
	       NOT_predict_rsp_instr_BITS_11_TO_7_1_EQ_predic_ETC___d90 :
	       predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d92 ;
  assign IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d38 =
	     predict_rsp_is_i32_not_i16 ?
	       predict_rsp_instr[6:0] != 7'b1101111 :
	       (predict_rsp_instr[15:13] != 3'b101 ||
		predict_rsp_instr[1:0] != 2'b01) &&
	       (predict_rsp_instr[15:13] != 3'b001 ||
		predict_rsp_instr[1:0] != 2'b01) &&
	       (predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d29 ||
		predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1001_0__ETC___d33 ||
		predict_rsp_instr[6:0] != 7'b1101111) ;
  assign IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d55 =
	     predict_rsp_is_i32_not_i16 ?
	       predict_rsp_instr[11:7] != 5'd1 &&
	       predict_rsp_instr[11:7] != 5'd5 :
	       predict_rsp_instr[15:13] == 3'b101 &&
	       predict_rsp_instr[1:0] == 2'b01 ||
	       (predict_rsp_instr[15:13] != 3'b001 ||
		predict_rsp_instr[1:0] != 2'b01) &&
	       (predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d29 ||
		(predict_rsp_instr[15:12] != 4'b1001 ||
		 predict_rsp_instr[11:7] == 5'd0 ||
		 predict_rsp_instr[6:2] != 5'd0 ||
		 predict_rsp_instr[1:0] != 2'b10) &&
		predict_rsp_instr[11:7] != 5'd1 &&
		predict_rsp_instr[11:7] != 5'd5) ;
  assign IF_predict_rsp_is_i32_not_i16_THEN_predict_rsp_ETC___d62 =
	     predict_rsp_is_i32_not_i16 ?
	       predict_rsp_instr[6:0] == 7'b1100111 :
	       (predict_rsp_instr[15:13] != 3'b101 ||
		predict_rsp_instr[1:0] != 2'b01) &&
	       (predict_rsp_instr[15:13] != 3'b001 ||
		predict_rsp_instr[1:0] != 2'b01) &&
	       (predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d29 ||
		predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1001_0__ETC___d33 ||
		predict_rsp_instr[6:0] == 7'b1100111) ;
  assign IF_predict_rsp_is_i32_not_i16_THEN_predict_rsp_ETC___d87 =
	     predict_rsp_is_i32_not_i16 ?
	       predict_rsp_instr[11:7] == 5'd1 ||
	       predict_rsp_instr[11:7] == 5'd5 :
	       (predict_rsp_instr[15:13] != 3'b101 ||
		predict_rsp_instr[1:0] != 2'b01) &&
	       (predict_rsp_instr[15:13] == 3'b001 &&
		predict_rsp_instr[1:0] == 2'b01 ||
		(predict_rsp_instr[15:12] != 4'b1000 ||
		 predict_rsp_instr[11:7] == 5'd0 ||
		 predict_rsp_instr[6:2] != 5'd0 ||
		 predict_rsp_instr[1:0] != 2'b10) &&
		(predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1001_0__ETC___d33 ||
		 predict_rsp_instr[11:7] == 5'd1 ||
		 predict_rsp_instr[11:7] == 5'd5)) ;
  assign NOT_bp_train_instr_BITS_11_TO_7_28_EQ_bp_train_ETC___d215 =
	     bp_train_instr[11:7] != bp_train_instr[19:15] ;
  assign NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1000__ETC___d137 =
	     bp_train_instr[15:12] != 4'b1000 ||
	     bp_train_instr[11:7] == 5'd0 ||
	     bp_train_instr[6:2] != 5'd0 ||
	     bp_train_instr[1:0] != 2'b10 ;
  assign NOT_bp_train_instr_BITS_15_TO_12_25_EQ_0b1001__ETC___d142 =
	     bp_train_instr[15:12] != 4'b1001 ||
	     bp_train_instr[11:7] == 5'd0 ||
	     bp_train_instr[6:2] != 5'd0 ||
	     bp_train_instr[1:0] != 2'b10 ;
  assign NOT_predict_rsp_instr_BITS_11_TO_7_1_EQ_predic_ETC___d90 =
	     predict_rsp_instr[11:7] != predict_rsp_instr[19:15] ;
  assign _theResult_____1__h2391 =
	     (_theResult____h2390 == 32'hFFFFFFFF && btb_bramcore2$DOA[53] &&
	      btb_bramcore2$DOA[52:31] == rg_pc[31:10]) ?
	       pred_pc__h3362 :
	       _theResult____h2390 ;
  assign _theResult_____1_fst__h7473 =
	     bp_train_cf_info[64] ?
	       _theResult_____1_fst__h7540 :
	       _theResult_____1_fst__h7584 ;
  assign _theResult_____1_snd__h7474 =
	     bp_train_cf_info[64] ?
	       _theResult_____1_snd__h7541 :
	       _theResult_____1_snd__h7585 ;
  assign _theResult____h2390 =
	     ((IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d38 ||
	       IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d55) &&
	      IF_predict_rsp_is_i32_not_i16_THEN_predict_rsp_ETC___d62 &&
	      (IF_predict_rsp_is_i32_not_i16_THEN_NOT_predict_ETC___d55 &&
	       IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d76 ||
	       IF_predict_rsp_is_i32_not_i16_THEN_predict_rsp_ETC___d87 &&
	       IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d76 &&
	       IF_predict_rsp_is_i32_not_i16_OR_predict_rsp_i_ETC___d93)) ?
	       rg_ras[31:0] :
	       32'hFFFFFFFF ;
  assign bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d169 =
	     bp_train_instr[15:12] == 4'b1000 &&
	     bp_train_instr[11:7] != 5'd0 &&
	     bp_train_instr[6:2] == 5'd0 &&
	     bp_train_instr[1:0] == 2'b10 ;
  assign bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d217 =
	     bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_A_ETC___d169 ||
	     (bp_train_instr_BITS_15_TO_12_25_EQ_0b1001_38_A_ETC___d157 ?
		bp_train_instr[11:7] != 5'd1 :
		NOT_bp_train_instr_BITS_11_TO_7_28_EQ_bp_train_ETC___d215) ;
  assign bp_train_instr_BITS_15_TO_12_25_EQ_0b1000_26_O_ETC___d187 =
	     (bp_train_instr[15:12] == 4'b1000 ||
	      bp_train_instr[15:12] == 4'b1001) &&
	     bp_train_instr[11:7] != 5'd0 &&
	     bp_train_instr[6:2] == 5'd0 &&
	     bp_train_instr[1:0] == 2'b10 ;
  assign bp_train_instr_BITS_15_TO_12_25_EQ_0b1001_38_A_ETC___d157 =
	     bp_train_instr[15:12] == 4'b1001 &&
	     bp_train_instr[11:7] != 5'd0 &&
	     bp_train_instr[6:2] == 5'd0 &&
	     bp_train_instr[1:0] == 2'b10 ;
  assign pred_pc__h3362 = { btb_bramcore2$DOA[30:0], 1'b0 } ;
  assign pred_pc__h3364 =
	     rg_pc + (predict_rsp_is_i32_not_i16 ? 32'd4 : 32'd2) ;
  assign predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d29 =
	     predict_rsp_instr[15:12] == 4'b1000 &&
	     predict_rsp_instr[11:7] != 5'd0 &&
	     predict_rsp_instr[6:2] == 5'd0 &&
	     predict_rsp_instr[1:0] == 2'b10 ;
  assign predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d92 =
	     predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1000_0__ETC___d29 ||
	     (predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1001_0__ETC___d33 ?
		predict_rsp_instr[11:7] != 5'd1 :
		NOT_predict_rsp_instr_BITS_11_TO_7_1_EQ_predic_ETC___d90) ;
  assign predict_rsp_instr_BITS_15_TO_12_9_EQ_0b1001_0__ETC___d33 =
	     predict_rsp_instr[15:12] == 4'b1001 &&
	     predict_rsp_instr[11:7] != 5'd0 &&
	     predict_rsp_instr[6:2] == 5'd0 &&
	     predict_rsp_instr[1:0] == 2'b10 ;
  assign ret_pc___1__h4117 = bp_train_pc + 32'd2 ;
  assign ret_pc__h4079 = bp_train_pc + 32'd4 ;
  always@(rf_btb_fsms$D_OUT_1 or bp_train_cf_info)
  begin
    case (rf_btb_fsms$D_OUT_1)
      2'b0: _theResult_____1_fst__h7540 = bp_train_cf_info[63:32];
      2'b01, 2'b10, 2'b11:
	  _theResult_____1_fst__h7540 = bp_train_cf_info[31:0];
    endcase
  end
  always@(rf_btb_fsms$D_OUT_1 or bp_train_cf_info)
  begin
    case (rf_btb_fsms$D_OUT_1)
      2'b0, 2'b01, 2'b10:
	  _theResult_____1_fst__h7584 = bp_train_cf_info[63:32];
      2'b11: _theResult_____1_fst__h7584 = bp_train_cf_info[31:0];
    endcase
  end
  always@(bp_train_cf_info or _theResult_____1_fst__h7473)
  begin
    case (bp_train_cf_info[98:97])
      2'd0: pred_PC__h7445 = _theResult_____1_fst__h7473;
      2'd1, 2'd2: pred_PC__h7445 = bp_train_cf_info[31:0];
      2'd3: pred_PC__h7445 = 32'hFFFFFFFF;
    endcase
  end
  always@(rf_btb_fsms$D_OUT_1)
  begin
    case (rf_btb_fsms$D_OUT_1)
      2'b0: _theResult_____1_snd__h7541 = 2'b01;
      2'b01: _theResult_____1_snd__h7541 = 2'b10;
      2'b10, 2'b11: _theResult_____1_snd__h7541 = 2'b11;
    endcase
  end
  always@(rf_btb_fsms$D_OUT_1)
  begin
    case (rf_btb_fsms$D_OUT_1)
      2'b0, 2'b01: _theResult_____1_snd__h7585 = 2'b0;
      2'b10: _theResult_____1_snd__h7585 = 2'b01;
      2'b11: _theResult_____1_snd__h7585 = 2'b10;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        rg_index <= `BSV_ASSIGNMENT_DELAY 9'd0;
	rg_ras <= `BSV_ASSIGNMENT_DELAY
	    512'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
	rg_resetting <= `BSV_ASSIGNMENT_DELAY 1'd1;
      end
    else
      begin
        if (rg_index$EN) rg_index <= `BSV_ASSIGNMENT_DELAY rg_index$D_IN;
	if (rg_ras$EN) rg_ras <= `BSV_ASSIGNMENT_DELAY rg_ras$D_IN;
	if (rg_resetting$EN)
	  rg_resetting <= `BSV_ASSIGNMENT_DELAY rg_resetting$D_IN;
      end
    if (rg_pc$EN) rg_pc <= `BSV_ASSIGNMENT_DELAY rg_pc$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    rg_index = 9'h0AA;
    rg_pc = 32'hAAAAAAAA;
    rg_ras =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    rg_resetting = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBranch_Predictor

