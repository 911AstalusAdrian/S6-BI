create table City(
	cityId int primary key,
	cityName varchar(50),
)

create table Organization(
	orgCode varchar(10) primary key,
	orgName varchar (100),
	orgHq int foreign key references City(cityId),
	orgFounded date
)

create table Country(
	countryCode varchar(3) primary key,
	countryName varchar(100),
	countryCapital int foreign key references City(cityId),
	countryArea int,
	countryPopulation int,
	countryContinent varchar(20),
)

create table OrgToCountry(
	org varchar(10) foreign key references Organization(orgCode),
	country varchar(3) foreign key references Country(countryCode)
)

drop table OrgToCountry
drop table Organization
drop table Country
drop table City