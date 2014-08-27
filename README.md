# lru-cache
[![Build Status](https://travis-ci.org/viruschidai/lru-cache.png?branch=master)](https://travis-ci.org/viruschidai/lru-cache)
A simple lru-cache library that can be used in node.js and browsers. The data structure used are a double linked list + a hash table. Theoretically, `set`, `get`, and `remove`  operations should be done in O(1).

## Installation

    npm install js-lru-cache -save


## APIs
* constructor
    - create a cache object
    ```javascript
    var LRUCache = require('lru-cache');
    var capacity = 10, // max number of values can be cached
        maxAge = 6000; // maxAge is in milliseconds
    var cache = new LRUCache(capacity, maxAge);
    ```

* set(key, value)
    - if the key does not exist, adding the value into the cache
    - if the key exists, update the value and the last visited time of the key
    - if the cache reaches its capability, the least used item in the cache will be removed
    ```javascript
    cache.set('key1', 'value1');
    ```

* get(key)
    - if the key exists, the value of the key is returned, the last visited time of the key is updated as well
    - if the key exists but is expired, return undefined
    - if the key does not exist, return undefined
    ```javascript
    cache.get('key1'); // should return 'value1'
    ```

* remove(key)
    - remove the key from cache
    ```javascript
    cache.remove('key1');
    cache.get('key1'); // return undefined
    ```

* keys()
    - return all the keys in the cache
    ```javascript
    cache.keys(); // return all keys in the cache
    ```

* values()
    - return all the values in the cache
    ```javascript
    cache.values(); // return all values in the cache
    ```

* size
    - the number of cache items
    ```javascript
    cache.size; // return the size of the cache
    ```

* capacity
    - the maximum number of items allowed in the cache
    ```javascript
    cache.capacity; // return the capacity of the cache
    ```

* maxAge
    -  the maximum age of the cached items. Note: each set or get operation will reset the last visited time of a cached item.
    ```javascript
    cache.maxAge; // return the maxAge of the cache in milliseconds
    ```


## License
The MIT License (MIT)

Copyright (c) 2013 viruschidai@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
