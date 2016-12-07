#include <plasp/pddl/Action.h>

#include <algorithm>

#include <plasp/pddl/Context.h>
#include <plasp/pddl/Domain.h>
#include <plasp/pddl/ExpressionContext.h>
#include <plasp/pddl/expressions/Type.h>

namespace plasp
{
namespace pddl
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Action
//
////////////////////////////////////////////////////////////////////////////////////////////////////

void Action::parseDeclaration(Context &context, Domain &domain)
{
	auto &parser = context.parser;

	auto action = std::make_unique<Action>(Action());

	action->m_name = parser.parseIdentifier();

	parser.expect<std::string>(":parameters");
	parser.expect<std::string>("(");

	ExpressionContext expressionContext(domain);
	expressionContext.variables.push(&action->m_parameters);

	// Read parameters
	expressions::Variable::parseTypedDeclarations(context, expressionContext, action->m_parameters);

	parser.expect<std::string>(")");

	// Parse preconditions and effects
	while (!parser.testAndReturn(')'))
	{
		parser.expect<std::string>(":");

		if (parser.testIdentifierAndSkip("precondition"))
			action->m_precondition = parsePreconditionExpression(context, expressionContext);
		else if (parser.testIdentifierAndSkip("effect"))
			action->m_effect = parseEffectExpression(context, expressionContext);

		parser.skipWhiteSpace();
	}

	// Store new action
	expressionContext.domain.actions().emplace_back(std::move(action));
}

////////////////////////////////////////////////////////////////////////////////////////////////////

const std::string &Action::name() const
{
	return m_name;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

const expressions::Variables &Action::parameters() const
{
	return m_parameters;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

const Expression *Action::precondition() const
{
	BOOST_ASSERT(m_precondition);

	return m_precondition.get();
}

////////////////////////////////////////////////////////////////////////////////////////////////////

const Expression *Action::effect() const
{
	BOOST_ASSERT(m_effect);

	return m_effect.get();
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void Action::normalize(expressions::DerivedPredicates &derivedPredicates)
{
	// Normalize preconditions and effects
	m_precondition = m_precondition->normalized()->decomposed(derivedPredicates);
	m_effect = m_effect->normalized();

	// Normalize parameter names
	for (size_t i = 0; i < m_parameters.size(); i++)
		m_parameters[i]->setName("X" + std::to_string(i));
}

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}
