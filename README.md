# OutlookCalendar-iOS

The file CalendarViewController is the initial VC which loads a collection and a events tableVC.

Have added transition for scrolling for expansion and contraction.

Have also added a base networking class and a class to fetch Yahoo response for weather forecast, but could not complete
integrating the response in UI.
The plan was to show some weather information for the Events.
For eg with NLP, or event location if we find the event is outdoors the user could be recommended for the weather 
and asked to take measures for the same, for eg . Umbrella for rainy, cloudy forecasts

Have as of noe hardcoded the calendar days to -3 months to next year, which I think is as per the outlook calendar.

Could not add a overlay on the CollectionView when scrolled to show months on top of the events.
But the approach which i was thinking to implement was to add a scrollView with month views inside(might not be the best way).


Have add Unit test cases for classes.

Could not start with UIUnit test cases, as there is a learning curve for me in that, but I have started looking into how to implement
UIUnit test cases.
