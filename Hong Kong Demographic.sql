Select * 
    FROM [dbo].[Statistics on Demographic Characteristics by District Council District];


-- Change data type for more accurate calculations
SELECT *
    FROM [dbo].[Statistics on Demographic Characteristics by District Council District]
Alter table [dbo].[Statistics on Demographic Characteristics by District Council District] Alter Column Number_of_persons_2016 DECIMAL;
Alter table [dbo].[Statistics on Demographic Characteristics by District Council District] Alter Column Number_of_persons_2017 DECIMAL;
Alter table [dbo].[Statistics on Demographic Characteristics by District Council District] Alter Column Number_of_persons_2018 DECIMAL;
Alter table [dbo].[Statistics on Demographic Characteristics by District Council District] Alter Column Number_of_persons_2019 DECIMAL;
Alter table [dbo].[Statistics on Demographic Characteristics by District Council District] Alter Column Number_of_persons_2020 DECIMAL;

-- Looking at total population by district in 2020
SELECT District_council_district_DCD, Max(Number_of_persons_2020) as pop_2020
FROM [dbo].[Statistics on Demographic Characteristics by District Council District]
Group by District_council_district_DCD
Order by pop_2020 desc


-- Population rate of change by district between 2019 and 2020
SELECT District_Council_district_DCD, 
    Number_of_persons_2019, 
    Number_of_persons_2020, 
    ((Number_of_persons_2020-Number_of_persons_2019)/Number_of_persons_2019)*100 as RateOfChange_dist
FROM [dbo].[Statistics on Demographic Characteristics by District Council District]
WHERE Age_group='Total' AND Sex='Both sexes'


-- Population rate of change by age between 2019 and 2020
SELECT Age_group, 
    Sum(Number_of_persons_2019) as sum_of_2019,
    Sum(Number_of_persons_2020) as sum_of_2020,
    ((Sum(Number_of_persons_2019) - Sum(Number_of_persons_2020))/Sum(Number_of_persons_2019))*100 as RateOfChange_age
FROM [dbo].[Statistics on Demographic Characteristics by District Council District]
WHERE Age_group <> 'Total'
Group By Age_group


