import web
import json
import urllib2
import chardet



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
    print "--------------------------" 
    print "New Beer Request "
    url = "http://www.abeerfor.me/api/beer/" + str(beer)
    result = urllib2.urlopen(url)
    rawdata = result.read()
    try:
        encoding = chardet.detect(rawdata)
        data = rawdata.decode(encoding['encoding'])
    except:
        data = rawdata
    print data
    data = json.loads(data)['data']
    data['ratings'] = beer_db[beer]
    return data

class index:
    def GET(self):
        web.header('Access-Control-Allow-Origin',      '*')
        return "{Heineken Sucks}"

class beer_id:
    def GET(self, beer):
        web.header('Access-Control-Allow-Origin',      '*')
    	if beer in beer_db:
    		return str(beer_db[beer])
    	else:
    		return []

class beer_rate:
    def GET(self, beer,rating):
        web.header('Access-Control-Allow-Origin',      '*')
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
        web.header('Access-Control-Allow-Origin',      '*')
        return json.dumps(beer_db)
    #	returnjson = []
	#print beer_db.keys()
   # 	for beer in beer_db.keys():
   #         returnjson.append(getBeerData(beer))
    #	return json.dumps(returnjson,indent=4, separators=(',', ': '))



if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()
