#include <plasp/pddl/TranslatorASP.h>

#include <plasp/utils/TranslatorException.h>

namespace plasp
{
namespace pddl
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TranslatorASP
//
////////////////////////////////////////////////////////////////////////////////////////////////////

TranslatorASP::TranslatorASP(const Description &description)
:	m_description(description)
{
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void TranslatorASP::translate(std::ostream &ostream) const
{
	translateDomain(ostream);

	if (m_description.containsProblem())
		translateProblem(ostream);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void TranslatorASP::translateDomain(std::ostream &ostream) const
{
	ostream
		<< "%---------------------------------------" << std::endl
		<< "% domain" << std::endl
		<< "%---------------------------------------" << std::endl << std::endl;

	const auto &domain = m_description.domain();

	// Types
	ostream << "% types" << std::endl;

	const auto &types = domain.types();

	std::for_each(types.cbegin(), types.cend(),
		[&](const auto &type)
		{
			ostream << "type(" << type->name() << ")." << std::endl;
		});

	// Type inheritance
	ostream << std::endl << "% type inheritance" << std::endl;

	std::for_each(types.cbegin(), types.cend(),
		[&](const auto &type)
		{
			const auto &parentTypes = type->parentTypes();

			std::for_each(parentTypes.cbegin(), parentTypes.cend(),
				[&](const auto &parentType)
				{
					ostream << "inheritsFrom(type(" << type->name() << "), type(" << parentType->name() << "))." << std::endl;
				});
		});
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void TranslatorASP::translateProblem(std::ostream &ostream) const
{
	ostream << std::endl
		<< "%---------------------------------------" << std::endl
		<< "% problem" << std::endl
		<< "%---------------------------------------" << std::endl << std::endl;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}