/**
 * Created by Herb on 9/27/2016.
 */

function LocalStorageStore() {
    riot.observable(this) // Riot provides our event emitter.
    var self = this

    /*
     {
         key:'myKey',
         data: etc.
     }
     */

    self.on('localstorage_set', function(data) {
        console.log('localstorage_set:',data);
        localStorage.setItem(data.key, JSON.stringify(data.data));
    })

    /*
    {
        key:'myKey',
        trigger:'myTrigger'
    }
     */
    self.on('localstorage_get', function(query) {
        console.log('localstorage_get:',query);
        var stored = localStorage.getItem(query.key);
        if(stored && stored != "undefined"){
            var restoredSession = JSON.parse(stored);
            self.trigger(query.trigger, restoredSession)
        }else{
            self.trigger(query.trigger, null)
        }
    })

    /*
     {
     key:'myKey',
     trigger:'myTrigger'
     }
     */
    self.on('localstorage_remove', function(query) {
       console.log('localstorage_get:',query);
       localStorage.removeItem(query.key);
    })

    /*

     */
    self.on('localstorage_clear', function() {
        console.log('localstorage_get:');
        localStorage.clear();
    })
}

if (typeof(module) !== 'undefined') module.exports = LocalStorageStore;



