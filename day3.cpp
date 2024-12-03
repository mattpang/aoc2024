// $clang++ -std=c++2b day3.cpp; ./a.out ./inputs/input-3.txt
#include <fstream>
#include <print>
#include <regex>
#include <cstdio>


int main(int argc, char *argv[])
{
    using namespace std::literals::string_literals;

    std::ifstream in;
    in.open(argv[1]);
    std::string line;

    std::intmax_t result_a{}, result_b{};

    std::regex re{ R"re((?:don't\(\)|do\(\)|mul\((\d+),(\d+)\)))re" };
    bool valid{ true };

    while (std::getline(in, line))
    {
        if (line.empty()) continue;

        auto start = std::sregex_iterator(line.begin(), line.end(), re);
        auto end = std::sregex_iterator();

        for (auto i = start; i != end; ++i)
        {
            if (i->str() == "do()")
            {
                valid = true;
            }
            else if (i->str() == "don't()")
            {
                valid = false;
            }
            else
            {
                const auto a = std::stoll((*i)[1].str());
                const auto b = std::stoll((*i)[2].str());
                const auto r = a * b;
                result_a += r;
                if (valid)
                {
                    result_b += r;
                }
            }
        }
    }

    std::println("Part 1: {}", result_a);
    std::println("Part 2: {}", result_b);

}