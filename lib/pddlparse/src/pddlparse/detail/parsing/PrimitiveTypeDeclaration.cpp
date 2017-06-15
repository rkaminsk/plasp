#include <pddlparse/detail/parsing/PrimitiveTypeDeclaration.h>

#include <pddlparse/ParserException.h>
#include <pddlparse/detail/ASTCopy.h>
#include <pddlparse/detail/parsing/PrimitiveType.h>

namespace pddl
{
namespace detail
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// PrimitiveTypeDeclaration
//
////////////////////////////////////////////////////////////////////////////////////////////////////

ast::PrimitiveTypeDeclarationPointer &parseAndAddUntypedPrimitiveTypeDeclaration(Context &context, ast::Domain &domain)
{
	auto &tokenizer = context.tokenizer;
	auto typeName = tokenizer.getIdentifier();

	auto &types = domain.types;

	const auto matchingPrimitiveType = std::find_if(types.begin(), types.end(),
		[&](const auto &primitiveType)
		{
			return primitiveType->name == typeName;
		});

	// Return existing primitive type
	if (matchingPrimitiveType != types.cend())
		return *matchingPrimitiveType;

	types.emplace_back(std::make_unique<ast::PrimitiveTypeDeclaration>(std::move(typeName)));

	return types.back();
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void parseAndAddPrimitiveTypeDeclarations(Context &context, ast::Domain &domain)
{
	auto &tokenizer = context.tokenizer;
	tokenizer.skipWhiteSpace();

	// Index on the first element of the current inheritance list
	size_t inheritanceIndex = 0;

	while (tokenizer.currentCharacter() != ')')
	{
		parseAndAddUntypedPrimitiveTypeDeclaration(context, domain);

		tokenizer.skipWhiteSpace();

		if (!tokenizer.testAndSkip<char>('-'))
			continue;

		// If existing, parse and store parent type
		auto parentType = parsePrimitiveType(context, domain);

		auto &types = domain.types;

		for (size_t i = inheritanceIndex; i < types.size(); i++)
			types[i]->parentTypes.emplace_back(ast::deepCopy(parentType));

		// All types up to now are labeled with their parent types
		inheritanceIndex = types.size() + 1;

		tokenizer.skipWhiteSpace();
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}