#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <filesystem>

#include "Config.h"
#include "Types.h"
#include "Utils.h"


#include "./MLP.h"


#ifdef ZEDBOARD
//#include <file_transfer/file_transfer.h>
//#include "../zedboard/file_transfer/file_transfer.h"
#endif

namespace ML
{


} 

#ifdef ZEDBOARD
extern "C" int main()
{

    printf("running on the Zedboard\n");
    printf("The year is: %d\n",2005 + 21);

    runMemoryTest();
}
#else
int main()
{
    printf("running on lab machines\n");
}
#endif
