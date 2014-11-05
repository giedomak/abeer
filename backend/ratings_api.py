import web
import json
import urllib2
import chardet
import pickle



urls = (
    '/', 'index',
    "/getbeer/(.+)", "beer_id",
    "/ratebeer/(.+)/(.+)", "beer_rate",
    "/popular", "popular"
)

db_file = "beerRatingDB.txt"
dumpF = open(db_file,'r')
try:
	beer_db = pickle.load(dumpF)
except:	
	beer_db = {'index':{}, 'data':[]}
dumpF.close()


def saveDB():
  threading.Timer(300.0, saveDB).start()
  print "Dumping DB to file"
  dump_db()

def dump_db():
	dumpF = open(db_file,'w')
	pickle.dump(beer_db, dumpF)
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
    data = json.loads(data)['data']
    return data

class index:
    def GET(self):
        web.header('Access-Control-Allow-Origin',      '*')
        return "{Heineken Sucks}"

class beer_id:
    def GET(self, beer):
        web.header('Access-Control-Allow-Origin',      '*')
    	if beer in beer_db['index']:
    		idx = int(beer_db['index'][beer])
    		return str(beer_db['data'][idx])
    	else:
    		return []

class beer_rate:
    def GET(self, beer,rating):
        web.header('Access-Control-Allow-Origin',      '*')
    	if beer in beer_db['index']:
    		idx = int(beer_db['index'][beer])
    		beer_db['data'][idx]['ratings'].append(int(rating))
    		beer_db['data'][idx]['sum_ratings'] += int(rating)
    		print beer_db
    		return beer_db['data'][idx]
    	else:
    		beerData = getBeerData(beer)
    		beerData['ratings'] = [int(rating)]
    		beerData['sum_ratings'] = int(rating)
    		# push beer entry to array
    		beer_db['data'].append(beerData)
    		idx = len(beer_db['data']) - 1
    		beer_db['index'][beer] = idx
    		print beer_db
    		return beer_db['data'][idx]


class popular:
    def GET(self):
        web.header('Access-Control-Allow-Origin',      '*')
        return json.dumps(beer_db['data'])
    


if __name__ == "__main__":
    app = web.application(urls, globals())
    saveDB()
    app.run()

