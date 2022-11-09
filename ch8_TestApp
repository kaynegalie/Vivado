// Test App 1 --------------------------------------------------

/****************************
 * Interact with AXI GPIO IP
 ****************************/
#include <stdio.h>
#include <unistd.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xgpio.h"

#define BTNS_DEVICE_ID   XPAR_AXI_GPIO_0_DEVICE_ID

int main()
{
    init_platform();
    // Declare button instance
	XGpio BTNInst;
	int status;
    // Initialize Push Buttons
    status = XGpio_Initialize(&BTNInst, BTNS_DEVICE_ID);
    if(status != XST_SUCCESS) return XST_FAILURE;
    // Set all buttons direction to inputs
    XGpio_SetDataDirection(&BTNInst, 1, 0xFF);
    print("Hello World\n\r");
    while(1)
    {
    	// while button_0 or button_1 not pressed
    	// sleep 10ms and while button_0 not released
    	while (XGpio_DiscreteRead(&BTNInst, 1)==0);
    	if (XGpio_DiscreteRead(&BTNInst, 1)==2) break;
    	else {
    	usleep(10000); // sleep 10ms
    	while (XGpio_DiscreteRead(&BTNInst, 1)==1);
    	print("Hello World btn0 press\n\r");
    	}
    }
    print("End program - btn1 press\n\r");
    cleanup_platform();
    return 0;
}

// Test App 2 ------------------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sh_reg_ip.h"
#include "xil_io.h"
#include "xstatus.h"

#define BASEADDR XPAR_SH_REG_IP_0_S_AXI_BASEADDR // sh_reg base address

#define depth 4 // register depth
static int test_vector[depth] = {1,2,3,4};

int main()
{
    init_platform();

    print("Hello World\n\r");
    int i;
    // shift in depth test vectors
    for (i=0;i<depth;i++){
    SH_REG_IP_mWriteReg(BASEADDR, 0, test_vector[i]);
    }
    // Iterate: print, compare slv_reg2 to expected result and circular shift
	for (i=0;i<2*depth;i++){
xil_printf("Output z: %d\n\r", (unsigned int)
       SH_REG_IP_mReadReg(BASEADDR, 8));
	if (SH_REG_IP_mReadReg(BASEADDR, 8) !=
		test_vector[i%depth]){
		xil_printf("Incorrect result: test %d\n\r", i);
		return XST_FAILURE;
	}// circular shift: a write to slv_reg1 (any data)
SH_REG_IP_mWriteReg(BASEADDR, 4, 0);
	}
    cleanup_platform();
    return 0;
}

// Test App 3 --------------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

#include "xparameters.h"
#include "bram_ip.h"
#include "xil_io.h"
#include "xil_types.h"

#define BASEADDR XPAR_BRAM_IP_0_S_AXI_BASEADDR

/*component user_logic
  we : IN STD_LOGIC;
  addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
  din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end component;
*/
//-------------------------------------------------------------------
// Registers/Ports Mapping
// =======================
// we: slv_reg_wren slv_reg_addr = 4
// addr=>slv_reg0(9 downto 0),
// din=>slv_reg1,
// dout=>slv_reg2
//-------------------------------------------------------------------

int main()
{
    unsigned int addr = 0;
    unsigned int data_in = 50;

    init_platform();

    print("bram_ip TestApp\n\r");
    //---------------------------------------------------------
    // write enable we is slv_reg_wren slv_reg_addr = 4 (slv_reg1)
    // write data from addr 0 to 9; addr is slv_reg0, din is slv_reg1
    //---------------------------------------------------------
    for (addr = 0; addr < 10 ; addr++) {
     BRAM_IP_mWriteReg(BASEADDR, 0, addr);
     BRAM_IP_mWriteReg(BASEADDR, 4, data_in + addr);
    }
    //---------------------------------------------
    // read data from addr 0 to 9; dout is slv_reg2
    //---------------------------------------------
    for (addr = 0; addr<10; addr++) {
     BRAM_IP_mWriteReg(BASEADDR, 0, addr);
     xil_printf("content of %d : %d\n\r", addr, (unsigned int)
                BRAM_IP_mReadReg(BASEADDR, 8));
    }

    cleanup_platform();
    return 0;
}

// Test App 4 ------------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "bram_acc_ip.h"
#include "xil_io.h"
#include "xil_types.h"

#define BASEADDR XPAR_BRAM_ACC_IP_0_S_AXI_BASEADDR

//-------------------------------------------------------------------
// Registers/Ports Mapping
// =======================
// run=>slv_reg0(0), reset=>slv_reg0(1),
// bus2mem_en=>slv_reg0(2),bus2mem_we=>slv_reg0(3),
// bus2mem_addr=>slv_reg1(9 downto 0),
// bus2mem_data_in=>slv_reg2,
// mem2bus_data_out=>slv_reg3,
// done=>slv_reg4(0)
//-------------------------------------------------------------------

int main()
{
    unsigned int addr = 0;
    unsigned int data_in = 0xF;
    init_platform();
    print("Test App for bram_ACC_ip\n\r");
    //-----------------------------------------------------------------
    // slv_reg0 write = reset + bus2mem_en + bus2mem_we = 2+4+8 = 0xE
    //-----------------------------------------------------------------
    BRAM_ACC_IP_mWriteReg(BASEADDR, 0, 0xE);
    //-----------------------------------------------------------------
    // slv_reg0 write = bus2mem_en + bus3=2mem_we = 4+8 = 0xC
    //-----------------------------------------------------------------
    BRAM_ACC_IP_mWriteReg(BASEADDR, 0, 0xC);
    //-----------------------------------------
    // writing data
    //-----------------------------------------
    for (addr = 0; addr<10; addr++) {
    BRAM_ACC_IP_mWriteReg(BASEADDR, 4, addr);
    BRAM_ACC_IP_mWriteReg(BASEADDR, 8, data_in + addr);
    }
    //----------------------------------------
    // run = slv_reg(0) = 0x1
    //----------------------------------------
    BRAM_ACC_IP_mWriteReg(BASEADDR, 0, 0x1);
    //----------------------------------------
    // wait on done flag slv_reg4(0)
    //----------------------------------------
    while (BRAM_ACC_IP_mReadReg(BASEADDR,16)==0);
    //------------------------------------------------------------
    // reading inputs and the total bus2mem_en = slv_reg(2) = 0x4
    //------------------------------------------------------------
    BRAM_ACC_IP_mWriteReg(BASEADDR, 0, 0x4);
    for (addr = 0; addr<11; addr++) {
    BRAM_ACC_IP_mWriteReg(BASEADDR, 4, addr);
	xil_printf("content of %d : %d\n\r", addr, (unsigned int)
			   BRAM_ACC_IP_mReadReg(BASEADDR,12));
    }
    cleanup_platform();
    return 0;
}

// Test App 5 ------------------------------------------

/*
  --->||-A---
             |
  --->||-B--(*)-->||-A*B--
                          |
  -w->||-temp---->||-C---(+)-->
 |            |                |
  ------------|----------------
              |
        z = A*B + C, rate = 1/2 latency = 1
 */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "mult_acc_ip.h"
#include "xil_io.h"
#include "xil_types.h"
#include "xil_printf.h"
#include "xstatus.h"
#define BASE_ADDR		XPAR_MULT_ACC_IP_0_S_AXI_BASEADDR
#define num_test		5
#define latency		1
#define rate			2

int main()
{
    init_platform();
    int i;

    // signed integers test vectors
    int a[num_test] = {-1,2,10,-10,-20};
    int b[num_test] = {1,-3,-5,10,10};
    int result = 0; // expected result signed integers

    // test vector x = a[15:0] & b[15:0]
    unsigned int x[num_test+latency];
    for (i = 0; i<num_test+latency;i++){
    	if (i<num_test){
    	x[i] = (a[i]<<16);
		x[i] += b[i]&0x0000ffff;
    	}
    	else // additional latency 0's get last output out of the pipe
    		x[i] = 0;
    }
    int j = 0; // test vector index

    print("Signed integer vectors verification\r\n");

    // SCLR high clear
    MULT_ACC_IP_mWriteReg(BASE_ADDR, 12, 1);
    // SCLR low enable
    MULT_ACC_IP_mWriteReg(BASE_ADDR, 12, 0);

    // test procedure
    // iterates rate*num_test additional latency cycles get outputs out the pipe

    for (i=0; i<(rate*num_test)+latency; i++) {
    	// output z not valid
    	if (i <= latency){
    		// apply x on even index
        	if (i%rate == 0)
        		MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, x[j]);
        	else {
    		MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, 0);
    		j++;
        	}
    	}
    	// output z valid check result
    	if (i > latency){
    		// apply x on even index
    		if (i%rate == 0){
    			MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, x[j]);
   				// compute expected answer signed integer test
    			result += a[j-latency]*b[j-latency];
        		if (result != (int)MULT_ACC_IP_mReadReg(BASE_ADDR, 8)){
        			xil_printf("error test vector %d\r\n", j);
        			return XST_FAILURE;
        		}
    		}
    		else {
    		MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, 0);
    		j++; // test vector index ++
    		}
    	}
    	// print signed integer test
    	xil_printf("t=%d x = %.8x  z = %d\n\r", i, MULT_ACC_IP_mReadReg(BASE_ADDR, 0),
    		(int) MULT_ACC_IP_mReadReg(BASE_ADDR, 8));
    }

    // QN test vectors
    // 7Q8 a: {-1.5, 2.75, 0.5, -0.75, 0.25}
    //     b: {0.125, -1.5, -0.5, 0.5, -0.875}
    unsigned int af[num_test] = {0xfe80,0x02c0,0x0080,0xff40,0x0040};
    unsigned int bf[num_test] = {0x0020,0xfe80,0xff80,0x0080,0xff20};
    
    //pre-calculated expected output z
    //15Q16 z: {-0.1875,-4.3125, −4.5625, −4.9375, −5.15625}
    unsigned int z[num_test] = {0xffffd000, 0xfffbb000, 0xfffb7000,
                                0xfffb1000, 0xfffad800};

    // test vector x = af[15:0] & bf[15:0]
    for (i = 0; i<num_test+latency;i++){
    	if (i<num_test){
    	x[i] = (af[i]<<16);
		x[i] += bf[i]&0x0000ffff;
    	}
    	else // additional latency 0's get last output out of the pipe
    		x[i] = 0;
    }

    print("Fraction vectors verification\r\n");
    // SCLR high clear
    MULT_ACC_IP_mWriteReg(BASE_ADDR, 12, 1);
    // SCLR low enable
    MULT_ACC_IP_mWriteReg(BASE_ADDR, 12, 0);
    j = 0; // reset test vector index

    for (i=0; i<(rate*num_test)+latency; i++) {
    	// output z not valid
    	if (i <= latency){
    		// apply x on even index
        	if (i%rate == 0)
        		MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, x[j]);
        	else {
    		MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, 0);
    		j++;
        	}
    	}
    	// output z valid check result
    	if (i > latency){
    		// apply x on even index
    		if (i%rate == 0){
    			MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, x[j]);
        		if (z[j-latency] != (int)MULT_ACC_IP_mReadReg(BASE_ADDR, 8)){
        			xil_printf("error test vector %d\r\n", j);
        			return XST_FAILURE;
        		}
    		}
    		else {
    		MULT_ACC_IP_mWriteReg(BASE_ADDR, 0, 0);
    		j++; // test vector index ++
    		}
    	}
    	// print 15Q16 fraction test
    	xil_printf("t=%d x = %.8x  z = %.8x\n\r", i,
MULT_ACC_IP_mReadReg(BASE_ADDR, 0),
    		(unsigned int) MULT_ACC_IP_mReadReg(BASE_ADDR, 8));
    }
    cleanup_platform();
    return 0;
}

// Test App 6 -------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "f_mac_ip.h"
#include "xil_io.h"
#include "xil_types.h"

#define BASEADDR     XPAR_F_MAC_IP_0_S0_AXI_BASEADDR

int main()
{
	int i;
// test vectors in hexadecimal
uint32_t a[5] = {0x40a00000, 0x41200000, 0x41c80000, 0x3f800000, 0x40400000};
uint32_t b[5] = {0x42960000, 0x42c80000, 0x42fa0000, 0x42480000, 0x42b40000};
uint32_t c[5] = {0x43bb8000, 0x44abe000, 0x458ca000, 0x458e3000, 0x4596a000};
	uint32_t z; // circuit output
	/* Test vectors in floating-point numbers
	 a[5] = {5.0, 10.0, 25.0, 1.0, 3.0}
	 b[5] = {75.0,100.0,125.0,50.0,90.0}
	 c[5] = {375, 1375, 4500, 4550, 4820}
	 */

    init_platform();

    print("test float multiply accumulate\n\r");

    /*  a => slv_reg0, b => slv_reg1, z => slv_reg2,
     *  reset => slv_reg3(1), req => slv_reg3(0), rdy => slv_reg4(0),
     */

    // reset and lower req
    F_MAC_IP_mWriteReg(BASEADDR, 12, 2);
    // lower reset
    F_MAC_IP_mWriteReg(BASEADDR, 12, 0);
    // print slv_reg2, accumulator clear?
    z = F_MAC_IP_mReadReg(BASEADDR, 8);
    xil_printf("initial value = %x\r\n", z);

    for (i=0;i<5;i++)
    {
    // write operands
    F_MAC_IP_mWriteReg(BASEADDR, 0, a[i]);
    xil_printf("(%x * ",F_MAC_IP_mReadReg(BASEADDR, 0));
    F_MAC_IP_mWriteReg(XPAR_F_MAC_IP_0_S0_AXI_BASEADDR, 4, b[i]);
    xil_printf("%x) + %x = ",F_MAC_IP_mReadReg(BASEADDR, 4), z);
    // request req = 1
    F_MAC_IP_mWriteReg(BASEADDR, 12, 1);
    // wait on rdy low
    while (F_MAC_IP_mReadReg(BASEADDR, 16));
    // lower req = 0
    F_MAC_IP_mWriteReg(BASEADDR, 12, 0);
    // wait on rdy high
    while (!F_MAC_IP_mReadReg(BASEADDR, 16));
    z = F_MAC_IP_mReadReg(BASEADDR, 8);
    // print answer
    xil_printf("%x\r\n",z);
    if (z != c[i]) print("error\r\n");
    }

    cleanup_platform();
    return 0;
}

// Test App 7 -------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xil_io.h"
#include "carte2polar_ip.h"

#define BASEADDR   XPAR_CARTE2POLAR_IP_0_S_AXI_BASEADDR
#define num_test 4

// test vectors and expected results
static uint32_t tv[num_test]  = {0x4000b5, 0xb500b5, 0xffc000b5, 0xff4b00b5};
static uint32_t res[num_test] = {0x2b00c0, 0x640100, 0xffd500c0, 0xff9c0100};

int main()
{
    init_platform();
    print("Hello World\n\r");

    for(int i = 0; i < num_test; i++){
    CARTE2POLAR_IP_mWriteReg(BASEADDR, 0, 0); //valid=0 resetn=0
    CARTE2POLAR_IP_mWriteReg(BASEADDR, 4, tv[i]); //apply test vector
    CARTE2POLAR_IP_mWriteReg(BASEADDR, 0, 3); //valid=1 resetn=1
    while(CARTE2POLAR_IP_mReadReg(BASEADDR, 12)==0);// o_valid slv_reg3(0)
    if (CARTE2POLAR_IP_mReadReg(BASEADDR, 12) != res[i]) print("ERROR\r\n");
    xil_printf("carte_xy = %.8x   z_polar  = %.8x\r\n",
    CARTE2POLAR_IP_mReadReg(BASEADDR, 4),CARTE2POLAR_IP_mReadReg(BASEADDR, 12));
    }
    cleanup_platform();
    return 0;
}

// Test App 8 --------------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_types.h"
#include "sort_ip.h"
#include "xparameters.h"

#define BASEADDR XPAR_SORT_IP_0_S0_AXI_BASEADDR
#define k 200 //k numbers to be sorted

int main()
{
    init_platform();
    unsigned int i;
    int num_array[200] = {
    		398102,585,	667,	7452,	1955,
    		32087,	4256,	6987,	9071,	1135,
    		3441,	346630,986952,4314,	2423,
    		4520,	5641,	243,	7092,	773,
    		2165,	485,	3516,	8185,	6530,
    		4651,	2565,	108102,8002,	3017,
    		7497,	9767,	5989,	4835,	1980,
    		8723,	5252,	7230,	8682,	8602,
    		781,	5214,	9023,	2340,	6772,
    		6643,	188,	1306,	3051,	5829,
    		8351,	2860,	6898,	4968,	8866,
    		2599,	9749,	5503,	3752,	3325,
    		6467,	6437,	2378,	8025,	3563,
    		201912,13014,	10402,	231,	6659383,
    		1418,	1334,	6073,	1039,	3083,
    		2274,	4082,	7010,	3416,	3298,
		9661,	4470,	8543,	7287,	8543,
		331661,5422,	908543,10361,	934749,
    		1789,	6675,	4546,	4800,	2994,
    		4660,	9549,	795,	1503,	996,
    		74,	8150,	9226,	4043,	3104,
    		102,	 85,	66, 	 452,	95,
    		9287,	5556,	 87,	 71,	6135,
    		241,	860,	692,	2314,	7423,
    		520,	5641,	243,	7092,	773,
    		65, 	981,	6516,	2285,	6730,
    		5551,	229,	102,	1182,	317,
    		71037,	133767,5989,	4835,	1980,
    		1253,	52239,	73910,	39862092,1038402,
    		70081,	534214,129023,232340,6772,
    		43,	8435188,29306,31251,5829,
    		8357921,2860,	6898,	13968,	81266,
    		2599,	9749,	38403,	322752,33115,
    		639467,6437,	103378,122502,203563,
    		14918,	1334,	919073,441039,2353083,
    		12274,	4082,	97200,	103416,3298,
    		239661,3234470,85232,7287,	8543,
    		59451789,6675,45123,4800,	2994,
    		2934660,39199549,100795,591503,20996,
    		112974,9110,	101226,554043,293104
    		};
    //---------------------------------
    // reset slv_reg1(0)
    //---------------------------------
    SORT_IP_mWriteReg(BASEADDR, 4, 0x1);
    SORT_IP_mWriteReg(BASEADDR, 4, 0x0);
    printf("device reset\n\r");
    printf("List\n\r");
    //---------------------------------
    // go download slv_reg1(1)
    //--------------------------------
    SORT_IP_mWriteReg(BASEADDR, 4, 0x2);
    // device waits on go low
    SORT_IP_mWriteReg(BASEADDR, 4, 0x0);
    //---------------------------------
    // download data: new_data: slv_reg3(0), data_put is bus2ip_w_ack
    // wait on new_data, data_put=1, wait on !new_data, data_put=0
    //---------------------------------
    for (i=0;i<k;i++) {
    // wait on new data = 1
    while ((unsigned int)
(SORT_IP_mReadReg(BASEADDR,12)&0x1)==0);
    // write data
    SORT_IP_mWriteReg(BASEADDR, 0, num_array[i]);
    // bus2ip_w_ack = 1 slv_reg1(2)
    SORT_IP_mWriteReg(BASEADDR, 4, 0x4);
    // wait on new data = 0
    while ((unsigned int)
(SORT_IP_mReadReg(BASEADDR,12)&0x1)==1);
    // bus2ip_w_ack = 0
    SORT_IP_mWriteReg(BASEADDR, 4, 0x0);
    if (i%5 == 4)
    printf("%u\n\r",(unsigned int)
SORT_IP_mReadReg(BASEADDR,0));
    else
    printf("%u  ",(unsigned int)SORT_IP_mReadReg(BASEADDR,0));
    }
    //----------------------------------------
    // wait on done sorting flag slv_reg3(1)
    //----------------------------------------
    while ((unsigned int)
(SORT_IP_mReadReg(BASEADDR,12)&0x2)==0);
    printf("done run\n\r");
    //----------------------------------
    // go upload slv_reg1(1)
    //----------------------------------
    SORT_IP_mWriteReg(BASEADDR, 4, 0x2);
    // wait on done low
    while ((unsigned int)
(SORT_IP_mReadReg(BASEADDR,12)&0x2)==1);
    // device waits on go low
    SORT_IP_mWriteReg(BASEADDR, 4, 0x0);
    printf("Sorted List\n\r");
    //----------------------------------
    // upload: wait on new data slv_reg3(0)
    // read acknowledge is bus2ip_r_ack; slv_reg1(3),
    //----------------------------------
    // bus2ip_r_ack = 0
    SORT_IP_mWriteReg(BASEADDR, 4, 0x0);
    for (i=0;i<k;i++) {
    // wait on new data = 1
    while ((unsigned int)
(SORT_IP_mReadReg(BASEADDR,12)&0x1)==0);
    // print result
    if (i%5 == 4)
    printf("%u\n\r",(unsigned int)
SORT_IP_mReadReg(BASEADDR,8));
    else
    printf("%u  ",(unsigned int)SORT_IP_mReadReg(BASEADDR,8));
    // bus2ip_r_ack = 1
    SORT_IP_mWriteReg(BASEADDR, 4, 0x8);
    // wait on new data = 0
    while ((unsigned int)
(SORT_IP_mReadReg(BASEADDR,12)&0x1)==1);
    // bus2ip_r_ack = 0
    SORT_IP_mWriteReg(BASEADDR, 4, 0x0);
    }

    printf("chill\n\r");

    return 0;
}

// Test App 9 ------------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "sp101_ip.h"
#include "xil_io.h"
#include "xil_types.h"
#define  BASEADDR	XPAR_SP101_IP_0_S_AXI_BASEADDR
#define  sc		0x01
#define  sl		0x11
#define  ss		0x21
#define  sadd		0x31
#define  shalt	0xff
#define  prog_length	15 // program1 5, program2 9, program3 15

//-------------------------------------------------------------------
// Registers/Ports Mapping
// =======================
// run=>slv_reg0(0),reset=>slv_reg0(1),
// bus2mem_en=>slv_reg0(2),bus2mem_we=>slv_reg0(3),
// bus2mem_addr=>slv_reg1(9 downto 0),
// bus2mem_data_in=>slv_reg2,
// mem2bus_data_out=>slv_reg3,
// done=>slv_reg4(0)
//-------------------------------------------------------------------
/* Machine Instructions
 * -------------------
 constant sc   (x"00000001");
 constant sl   (x"00000011");
 constant ss   (x"00000021");
 constant sadd (x"00000031");
 */
int main()
{

    init_platform();
    //-----------------------------------------------------------------
    // slv_reg0 write = reset + bus2mem_en + bus2mem_we = 2+4+8 = 0xE
    //-----------------------------------------------------------------
    SP101_IP_mWriteReg(BASEADDR, 0, 0x0000000E);
    //-----------------------------------------------------------------
    // Lower Reset: slv_reg0 write = bus2mem_en + bus2mem_we = 4+8 = 0xC
    //-----------------------------------------------------------------
    SP101_IP_mWriteReg(BASEADDR, 0, 0x0000000C);
    //-----------------------------------------
    // loading user code
    //----------------------------------------
    // # Program 1 stack 100 and 200
    // #  0    1    2    3    4
    // # {sc,  100, sc,  200, shalt}
    //----------------------------------------
    // # Program 2 stores 100 at addr 20 and load content of addr 20 on stack
    // #  0   1   2   3    4   5   6   7   8
    // # {sc, 20, sc, 100, ss, sc, 20, sl, shalt}
    //----------------------------------------
    // Program 3 (i is location 40)
    // # int i = 4;     i++;
    // #  0  1  2  3 4  5  6  7  8  9  10 11 12   13 14
    // # {sc,40,sc,5,ss,sc,40,sc,40,sl,sc, 1, sadd,ss,shalt}
    // ---------------------------------------


    unsigned int prog[prog_length] =
//    {sc,  100, sc,  200, shalt};
//    {sc, 20, sc, 300, ss, sc, 20, sl, shalt};
    {sc,40,sc,5,ss,sc,40,sc,40,sl,sc,1,sadd,ss,shalt};

    for (int i = 0; i < prog_length; i++) {
    	SP101_IP_mWriteReg(BASEADDR, 4, i);
    	SP101_IP_mWriteReg(BASEADDR, 8, prog[i]);
    }

    //--------------- END USER CODE ----------------------------

    //----------------------- RUN ------------------------------

    // Lower bus2mem_en, bus2mem_we and run = slv_reg0(0) = 0x1
    SP101_IP_mWriteReg(BASEADDR, 0, 0x1);

    // wait on done flag slv_reg4(0)
    while ((unsigned int) (SP101_IP_mReadReg(BASEADDR,16)&0x1)==0);

    //-------------------- READ RESULTS ------------------------------

    // enable bus2mem_en: slv_reg(2) = 0x4 run and bus2mem_we = 0
    SP101_IP_mWriteReg(BASEADDR, 0, 0x4);

    unsigned int addr = 40; // program1 128, program 128, program3 40
    SP101_IP_mWriteReg(BASEADDR, 4, addr);
    xil_printf("content of %d : %d\n\r", addr, (unsigned int)
    SP101_IP_mReadReg(BASEADDR,12));
//    SP101_IP_mWriteReg(BASEADDR, 4, addr+1);
//    xil_printf("content of %d : %d\n\r", addr+1, (unsigned int)
//    SP101_IP_mReadReg(BASEADDR,12));

    cleanup_platform();
    return 0;
}

// Test App 10 -----------------------------------------------
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "spiter_ip.h"
#include "xil_io.h"
#include "xil_types.h"

#define	BASEADDR	XPAR_SPITER_IP_0_S_AXI_BASEADDR
#define  sc		0x01
#define  sl		0x11
#define  ss		0x21
#define  sadd		0x31
#define  ssub		0x41
#define  sjlt		0x51
#define  sjgt		0x61
#define  sjeq		0x71
#define  sjmp		0xE1
#define  scmp		0xF1
#define  smult	0x101
#define  shalt	0xff

/* Hardware machine instructions
 * constant HALT : std_logic_vector(31 downto 0) := (x"000000FF");
 * constant SC   : std_logic_vector(31 downto 0) := (x"00000001");
 * constant sl   : std_logic_vector(31 downto 0) := (x"00000011");
 * constant ss   : std_logic_vector(31 downto 0) := (x"00000021");
 * constant sadd : std_logic_vector(31 downto 0) := (x"00000031");
 * constant ssub : std_logic_vector(31 downto 0) := (x"00000041");
 * constant sjlt : std_logic_vector(31 downto 0) := (x"00000051");
 * constant sjgt : std_logic_vector(31 downto 0) := (x"00000061");
 * constant sjeq : std_logic_vector(31 downto 0) := (x"00000071");
 * constant sjmp : std_logic_vector(31 downto 0) := (x"000000E1");
 * constant scmp : std_logic_vector(31 downto 0) := (x"000000F1");
 * constant smul : std_logic_vector(31 downto 0) := (x"00000101");
 */

//-------------------------------------------------------------------
// Registers/Ports Mapping
// =======================
// run=>slv_reg0(0), reset=>slv_reg0(1),
// bus2mem_en=>slv_reg0(2), bus2mem_we=>slv_reg0(3),
// bus2mem_addr=>slv_reg1(9 downto 0),
// bus2mem_data_in=>slv_reg2,
// mem2bus_data_out=>slv_reg3,
// done=>slv_reg4(0)
//-------------------------------------------------------------------

#define i		200
#define sum		201
#define a		202
#define LOOP		65
#define SKIP		75
#define prog_length	101
int main()
{
    init_platform();
    //-----------------------------------------------------------------
    // slv_reg0 write = reset + bus2mem_en + bus2mem_we = 2+4+8 = 0xE
    //-----------------------------------------------------------------
    SPITER_IP_mWriteReg(BASEADDR, 0, 0xE);
    //-----------------------------------------------------------------
    // Lower Reset: slv_reg0 write = bus2mem_en + bus2mem_we = 4+8 = 0xC
    //-----------------------------------------------------------------
    SPITER_IP_mWriteReg(BASEADDR, 0, 0xC);

//----------------- loading user code ----------------------
    //  main(){
    //  int i = 0;
    //  int sum = 0;
    //  int a[10] = {1,2,3,4,5,6,7,8,9,10};
    //    for (i=0;i<10;i++){
    //      sum = sum + a[i];
    //    }
    //  }

    unsigned int prog[prog_length] =
    {   sc,  i,    sc,    0,   ss,  sc,  sum,  sc,  0,  ss,
        sc,  202,  sc,    1,   ss,  sc,  203,  sc,  2,  ss,
        sc,  204,  sc,    3,   ss,  sc,  205,  sc,  4,  ss,
        sc,  206,  sc,    5,   ss,  sc,  207,  sc,  6,  ss,
        sc,  208,  sc,    7,   ss,  sc,  209,  sc,  8,  ss,
        sc,  210,  sc,    9,   ss,  sc,  211,  sc, 10,  ss,

        sc,    i,  sc,    0,   ss,  sc,    i,  sl, sc,  10,
        scmp, sc,SKIP, sjlt,shalt,  sc,  sum,  sc,sum,  sl,
        sc,    a,  sc,    i,   sl,sadd,   sl,sadd, ss,  sc,
        i,    sc,   i,   sl,   sc,   1, sadd,  ss, sc,LOOP,
        sjmp };

//for (i=0;i<10;i++) begins addr 60,LOOP = 65 (i<10), SKIP = 75 (skip halt)

    for (int j = 0; j < prog_length; j++) {
    	SPITER_IP_mWriteReg(BASEADDR, 4, j);
    	SPITER_IP_mWriteReg(BASEADDR, 8, prog[j]);
    }

//------------------- End of User Code -------------------

//------------------------- RUN ---------------------------

    // Lower bus2mem_en, bus2mem_we and run = slv_reg0(0) = 0x1
    SPITER_IP_mWriteReg(BASEADDR, 0, 0x1);

    // wait on done flag slv_reg4(0)
    while ((unsigned int) (SPITER_IP_mReadReg(BASEADDR,16)&0x1)==0);

//-------------------- READ RESULTS ---------------------

    // enable bus2mem_en: slv_reg(2) = 0x4 run and bus2mem_we = 0
    SPITER_IP_mWriteReg(BASEADDR, 0, 0x4);

    for (int addr=i;addr<a+10;addr++){
    SPITER_IP_mWriteReg(BASEADDR, 4, addr);
	xil_printf("content of %d : %d\n\r", addr, (unsigned int)
			   SPITER_IP_mReadReg(BASEADDR,12));
    }

    cleanup_platform();
    return 0;
}

// Test App 11 ---------------------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "splite_ip.h"
#include "xil_io.h"
#include "xil_types.h"

#define BASEADDR	XPAR_SPLITE_IP_0_S_AXI_BASEADDR

#define  sc		0x01
#define  sl		0x11
#define  ss		0x21
#define  sadd		0x31
#define  ssub		0x41
#define  sjlt		0x51
#define  sjgt		0x61
#define  sjeq		0x71
#define  sjmp		0xE1
#define  scmp		0xF1
#define  smul		0x101
#define  scall	0x81
#define  srtn		0x91
#define  salloc	0xA1
#define  sdealloc	0xB1
#define  slaa		0xC1
#define  slla		0xD1
#define  shalt	0xff

/* Hardware machine instructions
 * constant HALT : std_logic_vector(31 downto 0) := (x"000000FF");
 * constant SC   : std_logic_vector(31 downto 0) := (x"00000001");
 * constant sl   : std_logic_vector(31 downto 0) := (x"00000011");
 * constant ss   : std_logic_vector(31 downto 0) := (x"00000021");
 * constant sadd : std_logic_vector(31 downto 0) := (x"00000031");
 * constant ssub : std_logic_vector(31 downto 0) := (x"00000041");
 * constant sjlt : std_logic_vector(31 downto 0) := (x"00000051");
 * constant sjgt : std_logic_vector(31 downto 0) := (x"00000061");
 * constant sjeq : std_logic_vector(31 downto 0) := (x"00000071");
 * constant sjmp : std_logic_vector(31 downto 0) := (x"000000E1");
 * constant scmp : std_logic_vector(31 downto 0) := (x"000000F1");
 * constant smul : std_logic_vector(31 downto 0) := (x"00000101");
 * constant scall : std_logic_vector(31 downto 0) := (x"00000081");
 * constant srtn : std_logic_vector(31 downto 0) := (x"00000091");
 * constant salloc   : std_logic_vector(31 downto 0) := (x"000000A1");
 * constant sdealloc : std_logic_vector(31 downto 0) := (x"000000B1");
 * constant slaa : std_logic_vector(31 downto 0) := (x"000000C1");
 * constant slla : std_logic_vector(31 downto 0) := (x"000000D1");
 */

//-------------------------------------------------------------------
// Registers/Ports Mapping
// =======================
// run=>slv_reg0(0), reset=>slv_reg0(1),
// bus2mem_en=>slv_reg0(2), bus2mem_we=>slv_reg0(3),
// bus2mem_addr=>slv_reg1(9 downto 0),
// bus2mem_data_in=>slv_reg2,
// mem2bus_data_out=>slv_reg3,
// done=>slv_reg4(0)
//-------------------------------------------------------------------

#define x		12
#define fact		20
#define small		48
#define fact_len	31
#define main_len	11

#define num		12 // calculate num!

int main()
{
    init_platform();
    //-----------------------------------------------------------------
    // slv_reg0 write = reset + bus2mem_en + bus2mem_we = 2+4+8 = 0xE
    //-----------------------------------------------------------------
    SPLITE_IP_mWriteReg(BASEADDR, 0, 0xE);
    //-----------------------------------------------------------------
    // Lower Reset: slv_reg0 write = bus2mem_en + bus2mem_we = 4+8 = 0xC
    //-----------------------------------------------------------------
    SPLITE_IP_mWriteReg(BASEADDR, 0, 0xC);

//----------------- loading user code ----------------------

    // program - factorial recursive process
    //
    // int fact(int n) {
    // if (n==0) return 1;
    // else return n*fact(n-1);
    // }
    // #fact at address 20
    // #20 21 22   23 24 25 26   27 28    29
    // #sc 0  slaa sl sc 0  scmp sc small sjeq  // if n==0
    // #30 31 32   33
    // #sc 0  slaa sl	// stack n
    // #34 35 36 37 38   39 40   41 42 43 44   45
    // #sc 1  sc 0  slaa sl ssub sc 1  sc fact scall// fact(n-1)
    // #46   47
    // #smul srtn		// multiply  return
    // #small: at location 48
    // #48 49 50
    // #sc 1  srtn	// return 1;

    unsigned int fact_prog[fact_len] =
    {   sc,  0,  slaa, sl,  sc,    0,  scmp,  sc,small,sjeq,
        sc,  0,  slaa, sl,  sc,    1,  sc,     0, slaa,  sl,
      ssub, sc,     1, sc,fact,scall,smul,  srtn,   sc,   1,
      srtn};

    for (int j = 0; j < fact_len; j++) {
    	SPLITE_IP_mWriteReg(BASEADDR, 4, j+fact);
    	SPLITE_IP_mWriteReg(BASEADDR, 8, fact_prog[j]);
    }
    // #define num  12
    // main()
    // {
    //   int x = fact(num);
    // }
    // scall: stack argument, # of argument, subroutine addr
    // 0  1  2  3 4  5    6     7
    // sc 1  sc x sc fact scall shalt

    unsigned int prog[main_len] =
    {   sc, x, sc, num, sc,    1, sc, fact, scall, ss,   shalt};

    for (int j = 0; j < main_len; j++) {
    	SPLITE_IP_mWriteReg(BASEADDR, 4, j);
    	SPLITE_IP_mWriteReg(BASEADDR, 8, prog[j]);
    }

//------------------- End of User Code -------------------

//------------------------- RUN ---------------------------

    // Lower bus2mem_en, bus2mem_we and run = slv_reg0(0) = 0x1
    SPLITE_IP_mWriteReg(BASEADDR, 0, 0x1);

    // wait on done flag slv_reg4(0)
    while ((unsigned int) (SPLITE_IP_mReadReg(BASEADDR,16)&0x1)==0);

//-------------------- READ RESULTS ---------------------

    // enable bus2mem_en: slv_reg(2) = 0x4 run and bus2mem_we = 0
    SPLITE_IP_mWriteReg(BASEADDR, 0, 0x4);

    // result is at addr x
    SPLITE_IP_mWriteReg(BASEADDR, 4, x);
    int result = (unsigned int) SPLITE_IP_mReadReg(BASEADDR,12);
    xil_printf("%d! = %d\n\r", num, result);
    xil_printf("content of %d : %d\n\r", x, result);
    // print stack contents
    	    int addr = 128;
    	    SPLITE_IP_mWriteReg(BASEADDR, 4, addr);
    		xil_printf("content of %d : %d\n\r", addr, (unsigned int)
    				   SPLITE_IP_mReadReg(BASEADDR,12));
    		addr = 129;
    	    SPLITE_IP_mWriteReg(BASEADDR, 4, addr);
    		xil_printf("content of %d : %d\n\r", addr, (unsigned int)
    				   SPLITE_IP_mReadReg(BASEADDR,12));

    cleanup_platform();
    return 0;
}

// 8.7.1 Problem Test App 12 -------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

#include "xparameters.h"
#include "fib_ip.h"
#include "xil_io.h"
#include "xil_types.h"

int main()
{
    init_platform();
    int i;
    // declare expected answer variables
    unsigned int temp0 = 0, temp1 = 1, temp2 = 0;

    print("Fibonacci Numbers\n\r");
    for (i=0;i<48;i++) {
    // assign x, slv_reg0 to i
    FIB_IP_mWriteReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 0, i);
    // reset=1 slv_reg2(0), go=0 slv_reg2(1)
    FIB_IP_mWriteReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 8, 1);
    // reset=0 slv_reg2(0), go=1 slv_reg2(1)
    FIB_IP_mWriteReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 8, 2);
    // wait on done, slv_reg3(0)
    while(!FIB_IP_mReadReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 12)){ }
    // reset=0 slv_reg2(0), go=0 slv_reg2(1)
    FIB_IP_mWriteReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 8, 0);
    // print answer
    xil_printf("fib(%d) = %u\r\n",
    	FIB_IP_mReadReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 0),
    	(unsigned int)FIB_IP_mReadReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 4));
    // check against the expected answer 
    // fib(0) = 0, fib(1) = 1; fib(n) = fib(n-1) +  fib(n-2);
    if (FIB_IP_mReadReg(XPAR_FIB_IP_0_S0_AXI_BASEADDR, 4) != temp0)
        	print("error\r\n");
    temp2 = temp1 + temp0;
    temp0 = temp1;
    temp1 = temp2;
    }
    
    cleanup_platform();
    return 0;
}

// 8.7.2 Problem Test App 13 --------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

#include "xparameters.h"
#include "acc_ip.h"
#include "xil_io.h"
#include "xil_types.h"

#define BASEADDR  XPAR_ACC_IP_0_S0_AXI_BASEADDR
#define n         1000

int main()
{
    init_platform();
    xil_printf("Accumulator IP test: 1 + 2 + 3 + ... + %d\n\r", n);
    ACC_IP_mWriteReg(BASEADDR, 0, 0);// slv_reg0 = 0
    ACC_IP_mWriteReg(BASEADDR, 8, 1);// SCLR=1 slv_reg2(0)
    ACC_IP_mWriteReg(BASEADDR, 8, 0);// SCLR=0 slv_reg2(0)


    for (int i=0; i < n+1; i++) {
        ACC_IP_mWriteReg(BASEADDR, 0, i);//slv_reg0 valid
        if (i < 10)
        xil_printf("slv_reg0 = %d  Q = %d\r\n", i, ACC_IP_mReadReg(BASEADDR, 4));
    }

    ACC_IP_mWriteReg(BASEADDR, 0, 0);// clock last output out since latency = 1
 xil_printf("Last output, latency = 1: Q = %d\r\n",ACC_IP_mReadReg(BASEADDR, 4));
    cleanup_platform();
    return 0;
}

// 8.7.4 Problem Test App 14 -----------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "floatMA_ip.h"
#include "xil_io.h"
#include "xil_types.h"
#include "xparameters.h"

#define BASEADDR   XPAR_FLOATMA_IP_0_S_AXI_BASEADDR
#define num_test   3

int main()
{
    init_platform();
    /*
	U: user_logic port map(ck => S_AXI_ACLK,
	resetn => slv_reg0(0), i_valid => slv_reg0(1),
	a => slv_reg1, b => slv_reg2, c => slv_reg3,
	o_valid => slv_reg4(0), z => slv_reg5);
    */

    unsigned int tv_a[num_test] = {0x3f800000, 0x3f800000, 0xbc23d70a};
    unsigned int tv_b[num_test] = {0x3f800000, 0x3f800000, 0xbfe00000};
    unsigned int tv_c[num_test] = {0x3f800000, 0x40000000, 0x40100000};

    /* expected results
     * 1.0 * 1.0 + 1.0 = 2.0
     * 1.0 * 1.0 + 2.0 = 3.0
     * -0.01 * -1.75 + 2.25 = 2.2675 */

    unsigned int res[num_test] = {0x40000000, 0x40400000, 0x40111eb8};

    print("Hello World\n\r");
    for (int i = 0; i < num_test; i++){
    	FLOATMA_IP_mWriteReg(BASEADDR, 0, 0); // i_valid=0, resetn=0
    	FLOATMA_IP_mWriteReg(BASEADDR, 4, tv_a[i]);
    	FLOATMA_IP_mWriteReg(BASEADDR, 8, tv_b[i]);
    	FLOATMA_IP_mWriteReg(BASEADDR, 12, tv_c[i]);
    	FLOATMA_IP_mWriteReg(BASEADDR, 0, 3); // i_valid=1, resetn=1
        while (FLOATMA_IP_mReadReg(BASEADDR, 16)==0);
        if (FLOATMA_IP_mReadReg(BASEADDR, 20)!=res[i])
        	print("error");
        xil_printf("%.8x * %.8x + %.8x = %.8x\n\r",
        FLOATMA_IP_mReadReg(BASEADDR, 4), FLOATMA_IP_mReadReg(BASEADDR, 8),
		FLOATMA_IP_mReadReg(BASEADDR, 12),FLOATMA_IP_mReadReg(BASEADDR, 20));
        }
    cleanup_platform();
    return 0;
}

// 8.7.6 Problem Test App 15 --------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_types.h"
#include "complex_mult_cordic_ip.h"
#include "xparameters.h"

#define BASEADDR  XPAR_COMPLEX_MULT_CORDIC_IP_0_S_AXI_BASEADDR
#define num_test 2

int main()
{
    init_platform();
    unsigned int tv_x[num_test] = {0xb5, 0xff4b};// @1Q8 0.707, -0.707
    unsigned int tv_y[num_test] = {0xb5, 0xff4b};// @1Q8 0.707, -0.707
    unsigned int tv_k[num_test] = {0x80, 0xb5};  // @1Q8 0.5,    0.707
    unsigned int tv_a[num_test] = {0xc9, 0xff37};// @2Q7 1.57,  -1.57

    print("test (x+iy)*Kexp(ia) cordic rotation\n\r");
    /*
    U: user_logic port map(ck => S_AXI_ACLK,
	x => slv_reg0(15 downto 0), y => slv_reg1(15 downto 0),
	a => slv_reg2(15 downto 0), k => slv_reg3(15 downto 0),
	i_valid => slv_reg4(1), resetn => slv_reg4(0),
	o_valid => slv_reg5(0),
	p => slv_reg6(15 downto 0),q => slv_reg7(15 downto 0));
     */
    for (int i = 0; i < num_test; i++){
    COMPLEX_MULT_CORDIC_IP_mWriteReg(BASEADDR, 0, tv_x[i]);
    COMPLEX_MULT_CORDIC_IP_mWriteReg(BASEADDR, 4, tv_y[i]);
    COMPLEX_MULT_CORDIC_IP_mWriteReg(BASEADDR, 8, tv_a[i]);
    COMPLEX_MULT_CORDIC_IP_mWriteReg(BASEADDR, 12, tv_k[i]);
    COMPLEX_MULT_CORDIC_IP_mWriteReg(BASEADDR, 16, 0);
    COMPLEX_MULT_CORDIC_IP_mWriteReg(BASEADDR, 16, 3);
    while (COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 20)==0);
    xil_printf("(%.4x + i%4x) * %0.4x exp(i%0.4x) = %0.4x + i%0.4x\n\r",
COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 0), COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 4),
COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 12), COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 8),
COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 24),
COMPLEX_MULT_CORDIC_IP_mReadReg(BASEADDR, 28));
    }
    cleanup_platform();
    return 0;
}

// 8.7.6 Problem Test App 16 ----------------------------------------

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_types.h"
#include "givens_ip.h"
#include "xparameters.h"

#define BASEADDR    XPAR_GIVENS_IP_0_S_AXI_BASEADDR
#define num_test    2


int main()
{
    init_platform();
    /* Test data
		-- 0.707 @1Q8 = 0b5, sqrt(2)/2
		-- 0.5   @1Q8 = 080, 1/2
		-- 0.866 @1Q8 = 0dd, sqrt(3)/2
		-- x = 0b5, y = 0b5 45-triangle r=1
		-- x = 080, y = 0dd 60-triangle r=1
		expected results @1Q8
		1. r = 01.0000 0000 = 0x100, c = 0.707 = 0xb5, s = 0xb5
		2. r = 1 = 00.1111 1111 = 0xff, c = 0.5 = 0x80, s = 0xdd
     */
    unsigned int tv_x[num_test] = {0xb5, 0x80};// @1Q8 0.707,  0.707
    unsigned int tv_y[num_test] = {0xb5, 0xdd};// @1Q8 0.707, -0.707

    /* U: user_logic port map(ck => S_AXI_ACLK,
		resetn => slv_reg0(0), i_valid => slv_reg0(1),
		x => slv_reg1(15 downto 0), y => slv_reg2(15 downto 0),
		o_valid => slv_reg3(0),
		r => slv_reg4(15 downto 0),
		c => slv_reg5(15 downto 0), s => slv_reg6(15 downto 0)
     */
    print("Hello World\n\r");
    for (int i = 0; i < num_test; i++){
    	GIVENS_IP_mWriteReg(BASEADDR, 0, 0); // i_valid=0, resetn=0
    	GIVENS_IP_mWriteReg(BASEADDR, 4, tv_x[i]);
    	GIVENS_IP_mWriteReg(BASEADDR, 8, tv_y[i]);
    	GIVENS_IP_mWriteReg(BASEADDR, 0, 3); // i_valid=1, resetn=1
        while (GIVENS_IP_mReadReg(BASEADDR, 12)==0);
        xil_printf("y = %.4x, x = %.4x, r = %0.4x, c = %0.4x, s = %.4x\n\r",
		GIVENS_IP_mReadReg(BASEADDR, 8), GIVENS_IP_mReadReg(BASEADDR, 4),
		GIVENS_IP_mReadReg(BASEADDR, 16),
		GIVENS_IP_mReadReg(BASEADDR, 20), GIVENS_IP_mReadReg(BASEADDR, 24));
        }
    cleanup_platform();
    return 0;
}

