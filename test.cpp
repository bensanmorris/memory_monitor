#include <gtest/gtest.h>

TEST(MemoryTests, mem_leak) {
	auto mem = new uint8_t[10];
}

