# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
  SELECT
    name
  FROM
    countries
  WHERE
    gdp > (
      SELECT
        MAX(gdp)
      FROM
        countries
      WHERE
        continent = 'Europe'
    )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT
    a1.continent,
    name,
    a1.area
  FROM
    countries a1
  WHERE
    a1.area = (
      SELECT
        MAX(a2.area)
      FROM
        countries a2
      WHERE
        a1.continent = a2.continent 
    )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
  SELECT
    name,
    a1.continent
  FROM
    countries a1
  WHERE
    population > (3 * (
      SELECT
        MAX(a2.population)
      FROM
        countries a2
      WHERE
        a1.name != a2.name AND
        a1.continent = a2.continent
    ))
  SQL
end
