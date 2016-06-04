#ifndef __PLASP__PDDL__EXPRESSIONS__TYPE_H
#define __PLASP__PDDL__EXPRESSIONS__TYPE_H

#include <boost/variant.hpp>

#include <plasp/pddl/expressions/Either.h>
#include <plasp/pddl/expressions/PrimitiveType.h>
#include <plasp/utils/Parser.h>

namespace plasp
{
namespace pddl
{
namespace expressions
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Type
//
////////////////////////////////////////////////////////////////////////////////////////////////////

ExpressionPointer parseExistingPrimitiveType(utils::Parser &parser, Context &context,
	const Variables &parameters);

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}
}

#endif
