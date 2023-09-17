# University Scheduling System

A program that, given the available slots per week and a list of TA's and their respective workload, returns all possible variations of weekly schedules.

Example Query:

week_schedule(WeekSlots,TAs,DayMax,WeekSched).

Where:

WeekSlots is a list of 6 lists with each list representing a working day from Saturday till Thursday. A list representing a day is composed of 5 numbers representing the 5 slots in the day. The number at position i in a day list re- presents the number of parallel labs at slot i.

TAs is a list of structures of the form ta(Name,Load) where Name is the name of the TA and Load is an integer representing their teaching load.

DayMax is the maximum number of labs a TA can be assigned per day.

WeekSched is the weekly assignment of TAs to the labs. It is represented as a list of 6 lists. Each list represents a working day from Saturday to Thursday. Position i in a day list is a list containing the names of the assigned TAs to slot i in the day.

Sample Query:
week_schedule([[0,0,0,0,0],
                [0,0,0,1,0],
                [0,0,0,0,0],
                [0,2,0,1,0],
                [0,0,0,0,0],
                [0,0,0,0,0]],
[ta(k, 1), ta(m, 2), ta(n, 1)],
2,
WeekSched).
