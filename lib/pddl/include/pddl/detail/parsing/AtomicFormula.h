#ifndef __PDDL__DETAIL__PARSING__ATOMIC_FORMULA_H
#define __PDDL__DETAIL__PARSING__ATOMIC_FORMULA_H

#include <pddl/ASTForward.h>
#include <pddl/Context.h>
#include <pddl/detail/ASTContext.h>
#include <pddl/detail/VariableStack.h>

namespace pddl
{
namespace detail
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// AtomicFormula
//
////////////////////////////////////////////////////////////////////////////////////////////////////

std::optional<ast::AtomicFormula> parseAtomicFormula(Context &context, ASTContext &astContext, VariableStack &variableStack);

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}

#endif
