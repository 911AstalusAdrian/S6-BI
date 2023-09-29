use bi_db;

-- List all the countries which are members of NATO

select Country.countryName 
from Country where countryCode in 
(select OrgToCountry.country
from OrgToCountry where OrgToCountry.org = 'NATO')

-- List all the countries which are members of organizations founded before 1980

select countryName
from Country where countryCode in
(select distinct country
from OrgToCountry where org in 
	(select orgCode
	from Organization where orgFounded < '1980'))

-- List all the countries which are members of only one organization

with temp (orgPerCountry, ccode) as 
(
select count(OrgToCountry.org) as appearances, OrgToCountry.country
from OrgToCountry group by OrgToCountry.country
)

select Country.countryName from Country 
where countryCode in (select temp.ccode from temp where temp.orgPerCountry=1)


-- List all the capitals which are headquarter of no organization

select cityName from City
where cityId in
(select countryCapital from Country as A left join Organization as B 
on A.countryCapital = B.orgHq 
where B.orgHq is NULL)


-- List the population of each continent

select sum(Country.countryPopulation) as totalPopulation, Country.countryContinent
from Country group by Country.countryContinent

-- Count the countries of each continent

select count(*) as countriesPerContinent, Country.countryContinent
from Country group by Country.countryContinent