# Analyzing student's mental health - SQL
This is a SQL project idea suggested by Datacamp.com.

In this project, I will analyze the student data from a Japanese international university to find one of the most influencing factors that affect the mental health of students. 

## About the project:

A SQL table was created from the original dataset to store the following:

```
        mental_health

        ID                              SERIAL PRIMARY KEY
        inter_dom                       VARCHAR
        japanese_cate                   VARCHAR 
        english_cate                    VARCHAR
        academic                        VARCHAR
        age                             NUMERIC
        stay                            NUMERIC 
        todep                           NUMERIC
        tosc                            NUMERIC
        toas                            NUMERIC
```
    
## About the dataset:

- The original dataset can be found on https://www.proquest.com/docview/2548374683?sourcetype=Scholarly%20Journals#:~:text=The%20dataset%20comprises%20of%20268,students%20in%20a%20multicultural%20environment under Supplementary Material
- Part of the original dataset was extracted for the purpose of this project. 
- The new dataset contains the following fields:


```
Field           Definition
-----           ------------------------------------------------------
inter_dom       Types of students: 
                International student (Inter) or domestic student (Dom)

japanese_cate   Self-evaluation scale ranging from 1 to 5 regarding
                Japanese proficiency: 
                High (4 to 5), Medium(3) or Low (1 to 2)

english_cate    self-evaluation scale ranging from 1 to 5 regarding 
                English proficiency: 
                High (4 to 5), Medium (3) or Low (1 to 2)

academic        The current academic level of students: 
                Undergraduate (Under) or Graduate School (Grad)

age             Current age of students

stay            How long they have been in the university

todep           Total score of depression measured by Patient Health Questionnaire

tosc            Total social connectedness measured by Social Connectedness Scale

toas            Total score of Acculturative Stress
```

## About the SQL syntax used :

`GROUP BY`
The data is `GROUP BY` the field `'inter_dom'` to see what are the number and percentage of international and domestic students.

`COUNT`
This syntax is used a few times throughout the analysis e.g. to count the number of international vs domestic students

`SUM`
This is used to find the total number of students in the whole dataset

`CREATE VIEW`
<ul>
<li>A view is created to include new information about the depression level of students and categorize the students' length of stay </li>
<li> It also help to simplify complex queries that will be used multiple times.</li>
</ul>

`CASE`
This is used to categorize the data `'todep'` and `'stay'` columns. 


`CTE`
This is used to find the average tosc and toas of students who are less depressed.

