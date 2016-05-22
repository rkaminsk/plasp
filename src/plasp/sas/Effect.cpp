#include <plasp/sas/Effect.h>

#include <iostream>

#include <plasp/sas/VariableTransition.h>
#include <plasp/utils/Parsing.h>

namespace plasp
{
namespace sas
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Effect
//
////////////////////////////////////////////////////////////////////////////////////////////////////

Effect::Effect(Conditions conditions, Condition postcondition)
:	m_conditions(std::move(conditions)),
	m_postcondition(std::move(postcondition))
{
}

////////////////////////////////////////////////////////////////////////////////////////////////////

Effect Effect::fromSAS(std::istream &istream, const Variables &variables, Conditions &preconditions)
{
	Effect::Conditions conditions;

	const auto numberOfEffectConditions = utils::parse<size_t>(istream);
	conditions.reserve(numberOfEffectConditions);

	for (size_t k = 0; k < numberOfEffectConditions; k++)
		conditions.emplace_back(Condition::fromSAS(istream, variables));

	const auto variableTransition = VariableTransition::fromSAS(istream, variables);

	if (&variableTransition.valueBefore() != &Value::Any)
		preconditions.emplace_back(Condition(variableTransition.variable(), variableTransition.valueBefore()));

	const Effect::Condition postcondition(variableTransition.variable(), variableTransition.valueAfter());

	return Effect(std::move(conditions), std::move(postcondition));
}

////////////////////////////////////////////////////////////////////////////////////////////////////

const Effect::Conditions &Effect::conditions() const
{
	return m_conditions;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

const Effect::Condition &Effect::postcondition() const
{
	return m_postcondition;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}
