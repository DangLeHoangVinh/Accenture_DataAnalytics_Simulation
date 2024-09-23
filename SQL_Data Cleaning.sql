--Create database Forage_Stimulation;
-- Add files using Import Wizard (Azure Data Extentions)

Select * from Content;
Select * from Reactions;
Select * from ReactionTypes;


-- CLEANING DATA
-- removing rows that have values which are missing (NULL)
Delete from Content where URL IS NULL;
Delete from Reactions where (User_ID IS NULL) or (Type IS NULL);

-- Check and change the data type of some values within a column
-- Data Type
EXEC sp_help 'ReactionTypes';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'ReactionTypes';

-- Change Data Type
Alter Table ReactionTypes
Alter Column Score int;
-- Change Score Data Type from tinyint to int

-- Remove irrelevant column
Alter table Content
Drop column column1,User_ID,URL;

Alter table Reactions
Drop column column1,User_ID;

Alter table ReactionTypes
Drop column column1;

-- Change column Name
EXEC sp_rename "Content.Type", "Content_Type", "COLUMN";
EXEC sp_rename "Reactions.Type", "Reaction_Type", "COLUMN";
EXEC sp_rename "ReactionTypes.Type", "Reaction_Type", "COLUMN";