---
layout: default
title: Downloading Data
---

# Downloading Data

In this chapter we’ll download data sets from online sources and create working visualizations of that data. An incredible variety of data can be found online, much of which hasn’t been examined thoroughly. The ability to analyze this data allows you to discover patterns and connections that no one else has found.

## Changes from the book

There's a slight change to [Exercise 16-1](#exercise-16-1-san-francisco).

Pygal has been updated recently, which is a good thing; you're learning a library that's being steadily improved. If you're using the latest version of Pygal, you'll need to make some slight changes to the code in Chapter 16.

You can easily [install a version of Pygal](chapter_15/README.html#installing-pygal) that allows the code in the book to run exactly as it's written.

The first part of this update will tell you what to look for as you work through the section **Mapping Global Data Sets: JSON Format**, which begins on page 362. The second part will give you a page by page update.

Updates
---

### Exercise 16-1: San Francisco

You can still get historical weather data from Weather Underground in the CSV format, but the link to the CSV file is not visible on the screen. To get historical weather data, go to the [Weather Underground home page](https://www.wunderground.com), click on the Menu on the right side of the screen, and click on [Historical Weather](https://www.wunderground.com/history/). Enter a location, pick a starting date, and click Submit. A summary for this date will appear, with several tabs. Click on Custom, enter an end date on the next page, and click Get History.

If you scroll down you'll see the weather data for the range you requested, in a neatly formatted table. To get the CSV version of this data, append `&format=1` to the URL in your browser's address bar. You can do this by clicking in the address bar, pressing Ctrl-End, typing `&format=1`, and pressing Enter. Your URL should look something like this:

[https://www.wunderground.com/history/airport/PASI/2017/1/1/CustomHistory.html?dayend=1&monthend=7&yearend=2017&req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=&format=1](https://www.wunderground.com/history/airport/PASI/2017/1/1/CustomHistory.html?dayend=1&monthend=7&yearend=2017&req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=&format=1)

Once you see the data in CSV format you can either use the Save As dialog from your browser, or you can copy the data and paste it into a text editor to save it. It's good practice to use the *.csv* file extension when saving this kind of file.

### The `pygal_maps_world` package

The dictionary `COUNTRIES` and the world map module have been moved to a separate package called `pygal_maps_world`. Here's how to install this package:

    $ pip install --user pygal_maps_world

On Windows, this is:

    $ python -m pip install --user pygal_maps_world

### [*countries.py*](countries.py), [*country_codes.py*](country_codes.py)

The dictionary `COUNTRIES` needs to be imported from `pygal_maps_world` now:

    from pygal.maps.world import COUNTRIES

### *world_populations.py*, *americas.py*, *na_populations.py*

Pygal's world map has been moved and renamed, so these programs need an additional import statement. This update also affects one other line of code. Add the following import statement near the top of the file:

    from pygal.maps.world import World

In the line that creates the world map, change `Worldmap` to `World`:

    wm = World()

Page by page updates
---

In the following sections, bold lines of code differ from the code that appears in the book:

### p. 365, [*countries.py*](countries.py) and [*country_codes.py*](country_codes.py)

Use **`from pygal.maps.world import COUNTRIES`** instead of `from pygal.i18n import COUNTRIES`.

### p. 367, [*americas.py*](americas.py)

Use **`from pygal.maps.world import World`** instead of `import pygal`.

Use **`wm = World()`** instead of `wm = pygal.Worldmap()`.

### p. 368, [*na_populations.py*](na_populations.py)

Use **`from pygal.maps.world import World`** instead of `import pygal`.

Use **`wm = World()`** instead of `wm = pygal.Worldmap()`.

### p. 369-370, *world_populations.py*

Use **`from pygal.maps.world import World`** instead of `import pygal`.

Use **`wm = World()`** instead of `wm = pygal.Worldmap()`.

<span id="page_362"></span>

<span id="page_362"></span>

TRY IT YOURSELF \#1
-------------------

<span id="ch16exe1"></span>**16-1. San Francisco:** Are temperatures in
San Francisco more like temperatures in Sitka or temperatures in Death
Valley? Generate a high-low temperature plot for San Francisco and make
a comparison. (You can download weather data for almost any location
from *<http://www.wunderground.com/history/>*. Enter a location and date
range, scroll to the bottom of the page, and find a link labeled
*Comma-Delimited File*. Right-click this link, and save the data as a
CSV file.)

<span id="ch16exe2"></span>**16-2. Sitka-Death Valley Comparison:** The
temperature scales on the Sitka and Death Valley graphs reflect the
different ranges of the data. To accurately compare the temperature
range in Sitka to that of Death Valley, you need identical scales on the
y-axis. Change the settings for the y-axis on one or both of the charts
in [Figures 16-5](#ch16fig5) and [16-6](#ch16fig6), and make a direct
comparison between temperature ranges in Sitka and Death Valley (or any
two places you want to compare). You can also try plotting the two data
sets on the same chart.

<span id="ch16exe3"></span>**16-3. Rainfall:** Choose any location
you’re interested in, and make a visualization that plots its rainfall.
Start by focusing on one month’s data, and then once your code is
working, run it for a full year’s data.

<span id="ch16exe4"></span>**16-4. Explore:** Generate a few more
visualizations that examine any other weather aspect you’re interested
in for any locations you’re curious about.

<span id="page_375"></span>

TRY IT YOURSELF \#2
-------------------

<span id="ch16exe5"></span>**16-5. All Countries:** On the population
maps we made in this section, our program couldn’t automatically find
two-letter codes for about 12 countries. Work out which countries are
missing codes, and look through the `COUNTRIES` dictionary for the
codes. Add an `if`-`elif` block to `get_country_code()` so it returns
the correct country code values for these specific countries:

``` python
if country_name == 'Yemen, Rep.'
    return 'ye'
elif --snip--
```

Place this code after the `COUNTRIES` loop but before the `return None`
statement. When you’re finished, you should see a more complete map.

<span id="ch16exe6"></span>**16-6. Gross Domestic Product:** The Open
Knowledge Foundation maintains a data set containing the gross domestic
product (GDP) for each country in the world, which you can find at
*<http://data.okfn.org/data/core/gdp/>*. Download the JSON version of
this data set, and plot the GDP of each country in the world for the
most recent year in the data set.

<span id="ch16exe7"></span>**16-7. Choose Your Own Data:** The World
Bank maintains many data sets that are broken down for information on
each country worldwide. Go to *<http://data.worldbank.org/indicator/>*
and find a data set that looks interesting. Click the data set, click
the **Download Data** link, and choose **CSV**. You’ll receive three CSV
files, two of which are labeled *Metadata*; use the third CSV file.
Write a program that generates a dictionary with Pygal’s two-letter
country codes as its keys and your chosen data from the file as its
values. Plot the data on a `Worldmap` and style the map as you like.

<span id="ch16exe8"></span>**16-8. Testing the** `country_codes`
**Module:** When we wrote the `country_codes` module, we used `print`
statements to check whether the `get_country_code()` function worked.
Write a proper test for this function using what you learned in [Chapter
11](../chapter_11/README.md#ch11).


<span align="right"><a href='../chapter_17/README.md'>Next &#10095;</span></a>
<a href='../chapter_15/README.md'><span align="left">&#10094; Prev</span></a>
