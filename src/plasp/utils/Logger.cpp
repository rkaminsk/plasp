#include <plasp/utils/Logger.h>

#include <plasp/utils/ParserWarning.h>

namespace plasp
{
namespace utils
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Logger
//
////////////////////////////////////////////////////////////////////////////////////////////////////

Logger::Logger()
:	m_isPedantic{false}
{
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void Logger::setPedantic(bool isPedantic)
{
	m_isPedantic = isPedantic;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

void Logger::parserWarning(const Parser &parser, const std::string &text)
{
	if (m_isPedantic)
		throw ParserWarning(parser, text);

	std::cerr << "Warning: " << parser.row() << ":" << parser.column() << "\t" << text << std::endl;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}
