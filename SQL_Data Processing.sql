-- Tables
Select * from Content;
Select * from Reactions;
Select * from ReactionTypes;

-- Final Merger table -- Cần chỉnh sửa, đang bị sai so với final correct
Select Con.Content_ID, Content_Type, Category, Rea.Reaction_Type, Datetime, Sentiment, Score
Into Final_Table
from Content Con
Left join Reactions Rea on Con.Content_ID = Rea.Content_ID
left join ReactionTypes Typ on Rea.Reaction_Type = Typ.Reaction_Type

Select * from Final_Table

-- Find top 5 category
Select 
    Category,
    Sum(Score) Popuplarity_Score,
    Dense_Rank() over (order by Sum(Score) DESC) as 'Top'
from Final_Correct
Group by Category
Order by Sum(Score) DESC

-- Uncover Insights
Select * from Final_Table;

--How many unique categories are there? 16
Select distinct Category
from Final_Table

-- How many reactions are there to the most popular category?
-- Top 1 Category is Travel
with tam as (
Select 
    Category,
    Sum(Score) Popuplarity_Score,
    Dense_Rank() over (order by Sum(Score) DESC) as 'Rank'
from Final_Correct
Group by Category
)
Select *
from tam
where Rank = 1
Order by Popuplarity_Score

-- How many reactions?: 16

Select Category, Reaction_Type, count(Reaction_Type) as num_reaction
from Final_Correct
Where Category = 'animals'
group by Category,Reaction_Type
order by num_reaction DESC


-- What was the month with the most posts?
--By month and category
Select
    Year(Datetime)*100 + Month(Datetime) as YeaMon,
    Category,
    count(content_ID) as Num_post
From Final_Correct
Group by Year(Datetime)*100 + Month(Datetime), Category
Order by Year(Datetime)*100 + Month(Datetime)

--By month

Select
    Year(Datetime)*100 + Month(Datetime) as YeaMon,
    count(content_ID) as Num_post
From Final_Correct
Group by Year(Datetime)*100 + Month(Datetime)
Order by Year(Datetime)*100 + Month(Datetime)