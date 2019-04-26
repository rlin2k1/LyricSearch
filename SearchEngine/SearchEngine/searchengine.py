#!/usr/bin/python3

from flask import Flask, render_template, request

import search

application = app = Flask(__name__)
app.debug = True

@app.route('/search', methods=["GET"])
def dosearch():
    query = request.args['query']
    qtype = request.args['query_type']
    try:
        page_number = int(request.args['page_number'])
    except:
        page_number = 1

    """
    TODO:
    Use request.args to extract other information
    you may need for pagination.
    """
    #The other information I need to extract for pagination is the current_page number

    search_results, current_page = search.search(query, qtype, page_number)
    return render_template('results.html',
            query=query,
            results=len(search_results),
            search_results=search_results,
            page_number = current_page,
            query_type=qtype)

@app.route("/", methods=["GET"])
def index():
    if request.method == "GET":
        pass
    return render_template('index.html')

if __name__ == "__main__":
    app.run(host='0.0.0.0')