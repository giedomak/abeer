import web
import json
import urllib2


urls = (
    '/', 'index',
    "/getbeer/(.+)", "beer_id",
    "/ratebeer/(.+)/(.+)", "beer_rate",
    "/popular", "popular"

)

db_file = "beerRatingDB.txt"
dumpF = open(db_file,'r')
beer_db = json.load(dumpF)
dumpF.close()


def dump_db():
	dumpF = open(db_file,'w')
	print json.dumps(beer_db)
	dumpF.write(json.dumps(beer_db))
	dumpF.close()

def getBeerData(beer):
	return json.loads(urllib2.urlopen("http://www.abeerfor.me/api/beer/" + str(beer)).read())

class index:
    def GET(self):
        return "{Heineken Sucks}"

class beer_id:
    def GET(self, beer):
    	if beer in beer_db:
    		return str(beer_db[beer])
    	else:
    		return []

class beer_rate:
    def GET(self, beer,rating):
    	if beer in beer_db:
    		beer_db[beer].append(int(rating)) 
    		dump_db()
    		return beer_db[beer]
    	else:
    		beer_db[beer] = [int(rating)]
    		dump_db()
    		return beer_db[beer]

class popular:
    def GET(self):
    	returnjson = {}
    	for beer in beer_db:
    		returnjson[beer] = getBeerData(beer)
    		returnjson[beer]['ratings'] = beer_db[beer]
    	return json.dumps(returnjson,indent=4, separators=(',', ': '))



if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()