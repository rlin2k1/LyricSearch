#!/usr/bin/python3

import psycopg2
import re
import string
import sys

_PUNCTUATION = frozenset(string.punctuation)

def _remove_punc(token):
    """Removes punctuation from start/end of token."""
    i = 0
    j = len(token) - 1
    idone = False
    jdone = False
    while i <= j and not (idone and jdone):
        if token[i] in _PUNCTUATION and not idone:
            i += 1
        else:
            idone = True
        if token[j] in _PUNCTUATION and not jdone:
            j -= 1
        else:
            jdone = True
    return "" if i > j else token[i:(j+1)]

def _get_tokens(query):
    rewritten_query = []
    tokens = re.split('[ \n\r]+', query)
    for token in tokens:
        cleaned_token = _remove_punc(token)
        if cleaned_token:
            if "'" in cleaned_token:
                cleaned_token = cleaned_token.replace("'", "''")
            rewritten_query.append(cleaned_token)
    return rewritten_query

def _rewritten_query_to_tuple_string(rewritten_query):
    ret = ""
    num_tokens = len(rewritten_query)
    if num_tokens == 0:
        return ret # This should never run because we check for 0 length elsewhere
    if num_tokens == 1:
        ret += "('" + rewritten_query[0] + "')"
    else:
        ret += "('" + rewritten_query[0] + "'"
        for i in range(1, num_tokens):
            ret += ", '" + rewritten_query[i] + "'"
        ret += ")"
    return ret

def _remove_duplicates(some_list):
    ret = []
    for item in some_list:
        if item not in ret:
            ret.append(item)
    return ret

def search(query, query_type):
    rewritten_query = _get_tokens(query)

    """TODO
    Your code will go here. Refer to the specification for projects 1A and 1B.
    But your code should do the following:
    1. Connect to the Postgres database.
    2. Graciously handle any errors that may occur (look into try/except/finally).
    3. Close any database connections when you're done.
    4. Write queries so that they are not vulnerable to SQL injections.
    5. The parameters passed to the search function may need to be changed for 1B. 
    """

    tokens_list = _remove_duplicates(rewritten_query)
    num_tokens = len(tokens_list)
    if num_tokens == 0:
        return [], 1
    else:
        tokens_tuple = _rewritten_query_to_tuple_string(tokens_list)

    rows = []
    if query_type == "or":
        query_to_submit =  "SELECT song_name, artist_name, page_link\
                            FROM song\
                            NATURAL JOIN artist\
                            NATURAL JOIN (\
                              SELECT song_id, SUM(score) AS score_sum\
                              FROM tfidf\
                              WHERE token IN %s\
                              GROUP BY song_id\
                            ) score_sums\
                            ORDER BY score_sum DESC;" % tokens_tuple
    elif query_type == "and":
        query_to_submit =  "SELECT song_name, artist_name, page_link\
                            FROM song\
                            NATURAL JOIN artist\
                            NATURAL JOIN (\
                              SELECT song_id, SUM(score) AS score_sum\
                              FROM (\
                                SELECT *\
                                FROM tfidf\
                                WHERE token in %s\
                              ) filtered_tokens\
                              GROUP BY song_id\
                              HAVING COUNT(*) = %d\
                            ) score_sums\
                            ORDER BY score_sum DESC;" % (tokens_tuple, num_tokens)
    
    # print("")
    # print("")
    # print("tokens_tuple == %s" % tokens_tuple)
    # print("num_tokens == %d" % num_tokens)
    # print("query_to_submit == %s" % query_to_submit)
    # print("")
    # print("")

    try:
        conn = psycopg2.connect("dbname='searchengine' user='cs143' host='localhost' password='cs143'")
        cur = conn.cursor()
        cur.execute(query_to_submit)
        rows = cur.fetchall()
    except:
        print("ERROR OCCURRED WITH CONNECTING TO POSTGRESQL")
    finally:
        conn.close()
        cur.close()
    return rows, 2

if __name__ == "__main__":
    if len(sys.argv) > 2:
        result = search(' '.join(sys.argv[2:]), sys.argv[1].lower())
        print(result)
    else:
        print("USAGE: python3 search.py [or|and] term1 term2 ...")