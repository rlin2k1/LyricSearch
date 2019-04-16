Problems: None

Note: We used 'NOT NULL' for all attributes in every table. We assume that
      a user would provide values for all attributes if he or she were to
      modify the tables with additional data. We also assume that Part B of
      the project would require non-NULL values for queries and computations.

Citations: Besides Professor Rosario's slides and the links he provided
           in the Specification, we used one additional source from the
           PostgreSQL documentation:

             1) https://www.postgresql.org/docs/9.1/functions-string.html
                
                Specifically, we used the length(string) function while
                computing the max lengths of strings in a column so that
                we could specify limits to varchar(n). However, we used
                length(string) on the side, so it is not included in our
                queries.