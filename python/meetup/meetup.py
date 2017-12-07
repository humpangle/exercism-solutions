from datetime import date
import calendar

DAY_NAMES_INDICES = dict([(calendar.day_name[x], x) for x in range(7)])

def meetup_day(year, month, day_of_the_week, which):
    cal = calendar.monthcalendar(year, month)
    dates_ = []

    for week in cal:
        day_index = DAY_NAMES_INDICES[day_of_the_week]
        date_ = week[day_index]
        if date_ > 0:
            dates_.append(date_)

    if which == 'last':
        return date(year, month, max(dates_))

    for index, val in enumerate(dates_):
        if which == 'teenth' and val > 12:
            return date(year, month, val)
        elif which != 'teenth' and index == int(which[0]) - 1:
            return date(year, month, val)
    raise Exception()
