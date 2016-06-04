#ifndef __PLASP__UTILS__LOGGER_H
#define __PLASP__UTILS__LOGGER_H

#include <string>

#include <plasp/utils/Parser.h>

namespace plasp
{
namespace utils
{

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Logger
//
////////////////////////////////////////////////////////////////////////////////////////////////////

class Logger
{
	public:
		Logger();

		void setPedantic(bool isPedantic = true);

		void parserWarning(const Parser &parser, const std::string &text);

	private:
		bool m_isPedantic;
};

////////////////////////////////////////////////////////////////////////////////////////////////////

}
}

#endif
