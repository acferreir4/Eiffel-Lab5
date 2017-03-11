/*
 * Class EV_PNG_FORMAT
 */

#include "eif_macros.h"


#ifdef __cplusplus
extern "C" {
#endif

static const EIF_TYPE_INDEX egt_0_1024 [] = {0xFF01,222,0xFFFF};
static const EIF_TYPE_INDEX egt_1_1024 [] = {0xFF01,239,1023,0xFFFF};
static const EIF_TYPE_INDEX egt_2_1024 [] = {0xFF01,1023,0xFFFF};
static const EIF_TYPE_INDEX egt_3_1024 [] = {0,0xFFFF};
static const EIF_TYPE_INDEX egt_4_1024 [] = {0,0xFFFF};
static const EIF_TYPE_INDEX egt_5_1024 [] = {0xFF01,1023,0xFFFF};
static const EIF_TYPE_INDEX egt_6_1024 [] = {0xFF01,1023,0xFFFF};
static const EIF_TYPE_INDEX egt_7_1024 [] = {0,0xFFFF};
static const EIF_TYPE_INDEX egt_8_1024 [] = {0xFF01,14,0xFFFF};
static const EIF_TYPE_INDEX egt_9_1024 [] = {0xFF01,222,0xFFFF};
static const EIF_TYPE_INDEX egt_10_1024 [] = {0xFF01,222,0xFFFF};
static const EIF_TYPE_INDEX egt_11_1024 [] = {0xFF01,15,0xFFFF};
static const EIF_TYPE_INDEX egt_12_1024 [] = {0xFF01,1023,0xFFFF};
static const EIF_TYPE_INDEX egt_13_1024 [] = {0xFF01,228,0xFFFF};


static const struct desc_info desc_1024[] = {
	{EIF_GENERIC(NULL), 0xFFFFFFFF, 0xFFFFFFFF},
	{EIF_GENERIC(egt_0_1024), 0, 0xFFFFFFFF},
	{EIF_GENERIC(egt_1_1024), 1, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 2, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 3, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 4, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 5, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 6, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 7, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 8, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0183 /*193*/), 9, 0xFFFFFFFF},
	{EIF_GENERIC(egt_2_1024), 10, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 11, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 12, 0xFFFFFFFF},
	{EIF_GENERIC(egt_3_1024), 13, 0xFFFFFFFF},
	{EIF_GENERIC(egt_4_1024), 14, 0xFFFFFFFF},
	{EIF_GENERIC(egt_5_1024), 15, 0xFFFFFFFF},
	{EIF_GENERIC(egt_6_1024), 16, 0xFFFFFFFF},
	{EIF_GENERIC(egt_7_1024), 17, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 18, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 19, 0xFFFFFFFF},
	{EIF_GENERIC(egt_8_1024), 20, 0xFFFFFFFF},
	{EIF_GENERIC(egt_9_1024), 21, 0xFFFFFFFF},
	{EIF_GENERIC(egt_10_1024), 22, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 23, 0xFFFFFFFF},
	{EIF_GENERIC(egt_11_1024), 24, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 25, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 26, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 27, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x07FF /*1023*/), 28, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01B3 /*217*/), 29, 0xFFFFFFFF},
	{EIF_GENERIC(egt_12_1024), 30, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01A1 /*208*/), 14867, 0},
	{EIF_NON_GENERIC(0x01A1 /*208*/), 14868, 4},
	{EIF_NON_GENERIC(0x01A1 /*208*/), 14869, 8},
	{EIF_GENERIC(egt_13_1024), 14875, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14870, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14871, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14872, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14873, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14874, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14876, 0xFFFFFFFF},
};
void Init1024(void)
{
	IDSC(desc_1024, 0, 1023);
	IDSC(desc_1024 + 1, 1, 1023);
	IDSC(desc_1024 + 32, 556, 1023);
}


#ifdef __cplusplus
}
#endif
