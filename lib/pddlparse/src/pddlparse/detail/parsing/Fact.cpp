#include <pddlparse/detail/parsing/Fact.h>

#include <pddlparse/AST.h>
#include <pddlparse/detail/parsing/AtomicFormula.h>
#include <pddlparse/detail/parsing/Expressions.h>
#include <pddlparse/detail/parsing/Unsupported.h>

namespace pddl
{
namespace detail
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Fact
//
////////////////////////////////////////////////////////////////////////////////////////////////////

std::experimental::optional<ast::Fact> parseFact(Context &context, ASTContext &astContext, VariableStack &variableStack)
{
	auto &tokenizer = context.tokenizer;

	// Test unsupported expressions first
	const auto position = tokenizer.position();

	tokenizer.expect<std::string>("(");
	tokenizer.skipWhiteSpace();

	if (tokenizer.testIdentifierAndReturn("="))
	{
		tokenizer.seek(position);
		return parseUnsupported(context);
	}

	tokenizer.seek(position);

	// Now, test supported expressions
	std::experimental::optional<ast::Fact> fact;

	if ((fact = parseNot<ast::AtomicFormula>(context, astContext, variableStack, parseAtomicFormula))
		|| (fact = parseAtomicFormula(context, astContext, variableStack)))
	{
		return std::move(fact.value());
	}

	// Test for “at” expressions only now to allow “at” as a predicate name
	// TODO: allow this in compatibility mode only?
	if (tokenizer.testIdentifierAndReturn("at"))
	{
		tokenizer.seek(position);
		return parseUnsupported(context);
	}

	return std::experimental::nullopt;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}
