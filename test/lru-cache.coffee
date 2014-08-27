expect = require 'expect.js'
LRUCache = require '../src/lru-cache'

describe 'LRUCache', ->

  describe 'constructor', ->
    it 'should create a LRU cache with required capacity and maxAge', ->
      cache = new LRUCache 100, 6000
      expect(cache.maxAge).to.be 6000
      expect(cache.capacity).to.be 100


  describe 'set()', ->
    it 'should add key-value in cache', ->
      cache = new LRUCache 10, 6000
      expect(cache.size).to.be 0
      cache.set 'key1', 'value1'
      expect(cache.size).to.be 1
      expect(cache.get 'key1').to.be 'value1'

    it 'should update value if a key is already in the cache', ->
      cache = new LRUCache 10, 6000
      expect(cache.size).to.be 0
      cache.set 'key1', 'value1'
      expect(cache.size).to.be 1
      cache.set 'key1', 'value2'
      expect(cache.size).to.be 1
      expect(cache.get 'key1').to.be 'value2'

    it 'should remove the least visited node if the cache reaches its capacity', ->
      cache = new LRUCache 2, 6000
      cache.set 'key1', 'value1'
      cache.set 'key2', 'value2'
      cache.set 'key3', 'value3'
      expect(cache.keys()).to.eql ['key2', 'key3']


  describe 'get()', ->
    cache = new LRUCache 2, 1000

    it 'should return the cached value for a key exists in cache', ->
      cache.set 'key1', 'value1'
      expect(cache.get 'key1').to.be 'value1'

    it 'should return undefined for key does not exist in cache', ->
      expect(cache.get 'somekey').to.be undefined


  describe 'remove()', ->
    cache = new LRUCache 5, 3000

    it 'should remove the key value from cache', ->
      cache.set 'key1', 'value1'
      expect(cache.size).to.be 1
      cache.remove 'key1'
      expect(cache.size).to.be 0

    it 'should do nothing if the key does not exist in the cache', ->
      cache.set 'key1', 'value1'
      expect(cache.size).to.be 1
      cache.remove 'key2'
      expect(cache.size).to.be 1


  describe 'keys()', ->
    it 'should return all keys in the cache', ->
      cache = new LRUCache 2, 3000
      cache.set 'key1', 'value1'
      cache.set 'key2', 'value2'
      expect(cache.keys()).to.eql ['key1', 'key2']


  describe 'values()', ->
    it 'should return all values in cache', ->
      cache = new LRUCache 2, 3000
      cache.set 'key1', 'value1'
      cache.set 'key2', 'value2'
      expect(cache.values()).to.eql ['value1', 'value2']


  describe 'Expires', ->
    it 'should expire node after maxAge', (done) ->
      cache = new LRUCache 2, 1000
      cache.set 'key1', 'value1'
      expect(cache.get 'key1').to.be 'value1'
      setTimeout ->
        expect(cache.get 'key1').to.be undefined
        done()
      , 1500

    it 'should reset expire time of a node when set is called' , (done) ->
      cache = new LRUCache 2, 1000
      cache.set 'key1', 'value1'
      expect(cache.get 'key1').to.be 'value1'
      setTimeout ->
        cache.set 'key1', 'value1'
      , 800
      setTimeout ->
        expect(cache.get 'key1').to.be 'value1'
        done()
      , 1500

    it 'should reset expire time of a node when get is called' , (done) ->
      cache = new LRUCache 2, 1000
      cache.set 'key1', 'value1'
      expect(cache.get 'key1').to.be 'value1'
      setTimeout ->
        cache.get 'key1'
      , 800
      setTimeout ->
        expect(cache.get 'key1').to.be 'value1'
        done()
      , 1500
