#ifndef __SAS__DEBUGGING_H
#define __SAS__DEBUGGING_H

#include <iosfwd>

#include <plasp/sas/Description.h>

namespace plasp
{
namespace sas
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Debugging
//
////////////////////////////////////////////////////////////////////////////////////////////////////

std::ostream &operator >>(std::ostream &ostream, const Description &description);

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}

#endif