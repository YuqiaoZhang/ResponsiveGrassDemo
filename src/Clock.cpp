/**
* (c) Klemens Jahrmann
* klemens.jahrmann@net1220.at
*/

#include "Clock.h"

#if defined(_MSC_VER) && defined(_WIN32)

#include <Windows.h>

Clock::Clock() : startTime(0), lastTickTime(0), absoluteTime(0.0), lastFrameTime(0.0), tickTime(0)
{
	QueryPerformanceFrequency((LARGE_INTEGER*)&timerFrequency);
	QueryPerformanceCounter((LARGE_INTEGER*)&startTime);
	QueryPerformanceCounter((LARGE_INTEGER*)&lastTickTime);

	//set seed for rand calls
	srand((unsigned int)startTime);
}

Clock::~Clock()
{

}

void Clock::Tick()
{
	lastTickTime = tickTime;
	QueryPerformanceCounter((LARGE_INTEGER*)&tickTime);

	absoluteTime = (double)(tickTime - startTime) / (double)timerFrequency;
	lastFrameTime = (double)(tickTime - lastTickTime) / (double)timerFrequency;
}

double Clock::AbsoluteTime() const
{
	return absoluteTime;
}

double Clock::LastFrameTime() const
{
	if (!hasFixedTime)
		return lastFrameTime;
	return fixedFrameTime;
}

#elif defined(__GNUC__) && defined(__linux__)
#include <sys/time.h>
#include <assert.h>
#include <stdlib.h>

Clock::Clock() : startTime(0), lastTickTime(0), absoluteTime(0.0), lastFrameTime(0.0), tickTime(0)
{
	timerFrequency = 1000000LL;

	timeval tv1;
	int rtval1 = gettimeofday(&tv1, NULL);
	assert(rtval1 == 0);
	startTime = (1000000LL * static_cast<long long>(tv1.tv_sec) + static_cast<long long>(tv1.tv_usec));

	timeval tv2;
	int rtval2 = gettimeofday(&tv2, NULL);
	assert(rtval2 == 0);
	lastTickTime = (1000000LL * static_cast<long long>(tv2.tv_sec) + static_cast<long long>(tv2.tv_usec));

	//set seed for rand calls
	srand((unsigned int)startTime);
}

Clock::~Clock()
{

}

void Clock::Tick()
{
	lastTickTime = tickTime;
	
	timeval tv;
	int rtval = gettimeofday(&tv, NULL);
	assert(rtval == 0);
	tickTime = (1000000LL * static_cast<long long>(tv.tv_sec) + static_cast<long long>(tv.tv_usec));

	absoluteTime = (double)(tickTime - startTime) / (double)timerFrequency;
	lastFrameTime = (double)(tickTime - lastTickTime) / (double)timerFrequency;
}

double Clock::AbsoluteTime() const
{
	return absoluteTime;
}

double Clock::LastFrameTime() const
{
	if (!hasFixedTime)
		return lastFrameTime;
	return fixedFrameTime;
}

#endif