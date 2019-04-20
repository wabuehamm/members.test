import arrow

class TermineUtils:

    def last_month(self):
        return arrow.now().shift(months=-1).format('MMMM YYYY', locale='de_DE')

    def week_span(self, weekshift = 0):
        first_day = arrow.now().shift(weeks = weekshift, days=-arrow.now().weekday())
        last_day = arrow.now().shift(weeks = weekshift, days=6-arrow.now().weekday())
        return first_day.format('MMM D') + ' — ' + last_day.format('D YYYY')
    
    def day_format(self, dayshift = 0):
        return arrow.now().shift(days=dayshift).format('dddd, MMM D, YYYY', locale='de_DE')